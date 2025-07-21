{ pkgs, ... }:

let
  # Define the power event script using writeShellScriptBin
  powerEventScript = pkgs.writeShellScriptBin "power-event-handler" ''
    #!/bin/bash
    set -euo pipefail

    LOG_FILE="/var/log/power-event.log"
    ACTION="$1"

    # Create log directory if it doesn't exist
    mkdir -p "$(dirname "$LOG_FILE")"

    log() {
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
    }

    log "=========================================="
    log "Power event triggered: $ACTION"
    log "Running as: $(whoami) (UID: $(id -u))"

    # Define commands with full paths
    POWERPROFILESCTL_CMD="${pkgs.power-profiles-daemon}/bin/powerprofilesctl"
    BRIGHTNESSCTL_CMD="${pkgs.brightnessctl}/bin/brightnessctl"

    # Verify commands exist
    for cmd in "$POWERPROFILESCTL_CMD" "$BRIGHTNESSCTL_CMD"; do
        if ! [ -x "$cmd" ]; then
            log "ERROR: Command not found or not executable: $cmd"
            exit 1
        fi
    done

    # Function to execute commands with proper logging
    execute_cmd() {
        local cmd="$1"
        local description="$2"

        log "Executing: $description"
        if output=$($cmd 2>&1); then
            log "SUCCESS: $description"
            [ -n "$output" ] && log "Output: $output"
        else
            local exit_code=$?
            log "FAILED: $description (exit code: $exit_code)"
            log "Error output: $output"
            return $exit_code
        fi
    }

    case "$ACTION" in
        "plugged")
            log "AC power connected - switching to performance mode"
            execute_cmd "$POWERPROFILESCTL_CMD set performance" "Set performance profile"
            execute_cmd "$BRIGHTNESSCTL_CMD set 100%" "Set brightness to 100%"
            ;;
        "unplugged")
            log "AC power disconnected - switching to power saving mode"
            execute_cmd "$POWERPROFILESCTL_CMD set balanced" "Set balanced profile"
            execute_cmd "$BRIGHTNESSCTL_CMD set 40%" "Set brightness to 40%"
            ;;
        *)
            log "ERROR: Unknown action: $ACTION"
            exit 1
            ;;
    esac

    log "Power event handling completed successfully"
    log "=========================================="
  '';

  # Helper script to check current power status
  powerStatusScript = pkgs.writeShellScriptBin "power-status" ''
    #!/bin/bash
    echo "=== Power Status ==="
    echo "Current profile: $(${pkgs.power-profiles-daemon}/bin/powerprofilesctl get)"
    echo "Available profiles: $(${pkgs.power-profiles-daemon}/bin/powerprofilesctl list)"
    echo "Current brightness: $(${pkgs.brightnessctl}/bin/brightnessctl get)"
    echo "Max brightness: $(${pkgs.brightnessctl}/bin/brightnessctl max)"
    echo "AC adapter status:"
    find /sys/class/power_supply -name "A[DC]*" -exec sh -c 'echo "  $(basename {}): $(cat {}/online 2>/dev/null || echo unknown)"' \;
  '';
in
{
  # Enable power management services
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true; # Generally safe to enable on all systems
  services.auto-cpufreq.enable = false; # Conflicts with power-profiles-daemon

  # Optional: Enable powertop for power usage analysis
  # powerManagement.powertop.enable = true;

  # Install required packages
  environment.systemPackages = with pkgs; [
    power-profiles-daemon
    brightnessctl
    powerStatusScript # Add the helper script to system packages
  ];

  # Ensure brightness control permissions for users
  services.udev.extraRules = ''
    # Allow users in video group to control brightness
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="*", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="*", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"

    # Power supply rules with improved filtering
    SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_TYPE}=="Mains", ATTR{online}=="1", TAG+="systemd", ENV{SYSTEMD_WANTS}="power-plugged-event.service"
    SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_TYPE}=="Mains", ATTR{online}=="0", TAG+="systemd", ENV{SYSTEMD_WANTS}="power-unplugged-event.service"
  '';

  # Add users to video group for brightness control (adjust as needed)
  users.groups.video = { };

  # Create log rotation configuration
  services.logrotate.settings.power-event = {
    files = [ "/var/log/power-event.log" ];
    frequency = "weekly";
    rotate = 4;
    compress = true;
    delaycompress = true;
    missingok = true;
    notifempty = true;
    create = "644 root root";
  };

  # Systemd services with improvements
  systemd.services = {
    power-plugged-event = {
      description = "Handle AC power connected event";
      wants = [ "power-profiles-daemon.service" ];
      after = [ "power-profiles-daemon.service" "graphical-session.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${powerEventScript}/bin/power-event-handler plugged";
        User = "root"; # Explicitly set user
        Group = "root";
        # Security hardening
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ReadWritePaths = [ "/var/log" "/sys/class/backlight" ];
        NoNewPrivileges = true;
        # Timeout to prevent hanging
        TimeoutStartSec = "30s";
      };
    };

    power-unplugged-event = {
      description = "Handle AC power disconnected event";
      wants = [ "power-profiles-daemon.service" ];
      after = [ "power-profiles-daemon.service" "graphical-session.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${powerEventScript}/bin/power-event-handler unplugged";
        User = "root";
        Group = "root";
        # Security hardening
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ReadWritePaths = [ "/var/log" "/sys/class/backlight" ];
        NoNewPrivileges = true;
        # Timeout to prevent hanging
        TimeoutStartSec = "30s";
      };
    };

    # Optional: Service to set initial power profile on boot
    power-initial-setup = {
      description = "Set initial power profile based on AC status";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "power-profiles-daemon.service" ];
      after = [ "power-profiles-daemon.service" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "power-initial-setup" ''
          # Wait a moment for power supply detection
          sleep 2

          # Check if AC is connected
          ac_online=false
          for adapter in /sys/class/power_supply/A[DC]*; do
            if [ -f "$adapter/online" ] && [ "$(cat "$adapter/online")" = "1" ]; then
              ac_online=true
              break
            fi
          done

          if $ac_online; then
            ${powerEventScript}/bin/power-event-handler plugged
          else
            ${powerEventScript}/bin/power-event-handler unplugged
          fi
        '';
        User = "root";
        Group = "root";
        TimeoutStartSec = "30s";
      };
    };
  };

  # Optional: Add aliases for power management commands
  environment.shellAliases = {
    power-performance = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance";
    power-balanced = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced";
    power-saver = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver";
    brightness-high = "${pkgs.brightnessctl}/bin/brightnessctl set 100%";
    brightness-low = "${pkgs.brightnessctl}/bin/brightnessctl set 40%";
  };
}
