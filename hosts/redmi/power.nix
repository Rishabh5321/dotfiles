{ pkgs, ... }:

let
  # Define the power event script using writeShellScriptBin
  powerEventScript = pkgs.writeShellScriptBin "power-event-handler" ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail # Exit on error, unset variable, or pipe failure

    LOG_FILE="/tmp/power-event.log"

    echo "----------------------------------------" >> "$LOG_FILE"
    echo "Script triggered at $(date) with action: $1" >> "$LOG_FILE"
    echo "Running as user: $(whoami) (UID: $(id -u), GID: $(id -g))" >> "$LOG_FILE"
    echo "Initial PATH: $PATH" >> "$LOG_FILE"
    echo "--- Environment Variables Start ---" >> "$LOG_FILE"
    env >> "$LOG_FILE"
    echo "--- Environment Variables End ---" >> "$LOG_FILE"
    echo "---" >> "$LOG_FILE"

    ACTION=$1

    # Define powerprofilesctl and brightnessctl commands using full paths
    # wallrun is not needed here as these commands don't require a graphical session
    POWERPROFILESCTL_CMD="${pkgs.power-profiles-daemon}/bin/powerprofilesctl"
    BRIGHTNESSCTL_CMD="${pkgs.brightnessctl}/bin/brightnessctl"

    # Check if commands exist (optional but good practice)
    if ! [ -x "$POWERPROFILESCTL_CMD" ]; then
      echo "CRITICAL ERROR: powerprofilesctl command not found or not executable at $POWERPROFILESCTL_CMD" >> "$LOG_FILE"
      exit 1
    fi
    if ! [ -x "$BRIGHTNESSCTL_CMD" ]; then
      echo "CRITICAL ERROR: brightnessctl command not found or not executable at $BRIGHTNESSCTL_CMD" >> "$LOG_FILE"
    fi

    if [ "$ACTION" = "plugged" ]; then
      echo "Action: PLUGGED. Setting performance and brightness 80%" >> "$LOG_FILE"
      echo "Executing: $POWERPROFILESCTL_CMD set performance" >> "$LOG_FILE"
      "$POWERPROFILESCTL_CMD" set performance >> "$LOG_FILE" 2>&1
      echo "Return code for powerprofilesctl: $?" >> "$LOG_FILE"

      echo "Executing: $BRIGHTNESSCTL_CMD set 80%" >> "$LOG_FILE"
      "$BRIGHTNESSCTL_CMD" set 80% >> "$LOG_FILE" 2>&1
      echo "Return code for brightnessctl: $?" >> "$LOG_FILE"

    elif [ "$ACTION" = "unplugged" ]; then
      echo "Action: UNPLUGGED. Setting balanced and brightness 40%" >> "$LOG_FILE"
      echo "Executing: $POWERPROFILESCTL_CMD set balanced" >> "$LOG_FILE"
      "$POWERPROFILESCTL_CMD" set balanced >> "$LOG_FILE" 2>&1
      echo "Return code for powerprofilesctl: $?" >> "$LOG_FILE"

      echo "Executing: $BRIGHTNESSCTL_CMD set 40%" >> "$LOG_FILE"
      "$BRIGHTNESSCTL_CMD" set 40% >> "$LOG_FILE" 2>&1
      echo "Return code for brightnessctl: $?" >> "$LOG_FILE"
    else
      echo "Unknown action: $1" >> "$LOG_FILE"
    fi
    echo "Script finished at $(date)" >> "$LOG_FILE"
    echo "----------------------------------------" >> "$LOG_FILE"
  '';
in
{

  services.power-profiles-daemon.enable = true;

  powerManagement.powertop.enable = true;

  environment.systemPackages = with pkgs; [
    power-profiles-daemon
    brightnessctl
  ];

  # Enable thermald (only necessary if on Intel CPUs)
  services.thermald.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{online}=="1", ENV{POWER_EVENT}="plugged", RUN+="${powerEventScript}/bin/power-event-handler plugged"
    SUBSYSTEM=="power_supply", ATTR{online}=="0", ENV{POWER_EVENT}="unplugged", RUN+="${powerEventScript}/bin/power-event-handler unplugged"
  '';
}
