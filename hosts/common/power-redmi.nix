{ pkgs, ... }:

let
  # Define the power event script using writeShellScriptBin
  powerEventScript = pkgs.writeShellScriptBin "power-event-handler" ''
    #!/bin/bash
    set -euo pipefail

    LOG_FILE="/tmp/power-event.log"

    echo "----------------------------------------" >> "$LOG_FILE"
    echo "Script triggered at $(date) with action: $1" >> "$LOG_FILE"
    echo "Running as user: $(whoami) (UID: $(id -u), GID: $(id -g))" >> "$LOG_FILE"
    echo "Initial PATH: $PATH" >> "$LOG_FILE"
    echo "--- Environment Variables Start ---" >> "$LOG_FILE"
    env >> "$LOG_FILE"
    echo "--- Environment Variables End ---" >> "$LOG_FILE"
    echo "---" >> "$LOG_FILE"

    ACTION="$1"

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

      echo "Executing: $BRIGHTNESSCTL_CMD set 100%" >> "$LOG_FILE"
      "$BRIGHTNESSCTL_CMD" set 100% >> "$LOG_FILE" 2>&1
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
  #powerManagement.powertop.enable = true; # Uncomment if you want to enable powertop

  environment.systemPackages = with pkgs; [
    power-profiles-daemon
    brightnessctl
  ];

  # Enable thermald (only necessary if on Intel CPUs)
  services.thermald.enable = true;

  # Define systemd services that will be triggered by udev
  systemd.services = {
    # Service for when power is plugged in
    "power-plugged-event" = {
      # Renamed for clarity: this service handles the 'plugged' event
      description = "Handle power plugged event";
      # This service is triggered by udev rules, so it doesn't need 'wantedBy' or 'pathConfig' here.
      serviceConfig = {
        Type = "oneshot"; # Runs the command and exits
        ExecStart = "${powerEventScript}/bin/power-event-handler plugged";
        # Ensure the power-profiles-daemon is active before attempting to use it
        Requires = [ "power-profiles-daemon.service" ];
      };
    };

    # Service for when power is unplugged
    "power-unplugged-event" = {
      # Renamed for clarity: this service handles the 'unplugged' event
      description = "Handle power unplugged event";
      # This service is triggered by udev rules, so it doesn't need 'wantedBy' or 'pathConfig' here.
      serviceConfig = {
        Type = "oneshot"; # Runs the command and exits
        ExecStart = "${powerEventScript}/bin/power-event-handler unplugged";
        # Ensure the power-profiles-daemon is active before attempting to use it
        Requires = [ "power-profiles-daemon.service" ];
      };
    };
  };

  # Udev rules to trigger the systemd services based on power supply status
  services.udev.extraRules = ''
    # Rule for power plugged in: When online attribute becomes '1' (plugged in)
    SUBSYSTEM=="power_supply", ATTR{online}=="1", TAG+="systemd", ENV{SYSTEMD_WANTS}="power-plugged-event.service"

    # Rule for power unplugged: When online attribute becomes '0' (unplugged)
    SUBSYSTEM=="power_supply", ATTR{online}=="0", TAG+="systemd", ENV{SYSTEMD_WANTS}="power-unplugged-event.service"
  '';

  boot.loader.grub.default = 2;

  # boot.loader.grub.extraEntries = ''
  #   menuentry "EndeavourOS (on /dev/nvme0n1p9)" {
  #       insmod ext2
  #       insmod btrfs
  #       insmod part_gpt
  #       insmod fat

  #       # Boot partition (contains kernel/initramfs)
  #       search --no-floppy --fs-uuid --set=boot 849599ff-1f14-453c-965b-8fc3d0066bb1
  #       # Root partition (btrfs root)
  #       search --no-floppy --fs-uuid --set=root 2dbbbf95-60ba-4a9e-a5ff-37c17c78b6f2

  #       linux ($boot)/vmlinuz-linux root=UUID=2dbbbf95-60ba-4a9e-a5ff-37c17c78b6f2 rw rootflags=subvol=@
  #       initrd ($boot)/intel-ucode.img ($boot)/initramfs-linux.img
  #   }
  # '';
}
