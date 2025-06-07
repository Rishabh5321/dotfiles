{ pkgs, ... }:
{

  # services.auto-cpufreq.enable = true;

  services.power-profiles-daemon.enable = true;

  # powerManagement.powertop.enable = true;

  # Enable thermald (only necessary if on Intel CPUs)
  services.thermald.enable = true;

  # services.tlp.enable = true;

  services.udev.extraRules = ''
    # Rule for AC adapter connect/disconnect events
    SUBSYSTEM=="power_supply", KERNEL=="ACAD", ACTION=="change", ATTR{online}=="1", RUN+="${pkgs.systemd}/bin/systemctl start --no-block --user ac-connected.service"
    SUBSYSTEM=="power_supply", KERNEL=="ACAD", ACTION=="change", ATTR{online}=="0", RUN+="${pkgs.systemd}/bin/systemctl start --no-block --user ac-disconnected.service"
  '';

  # Define systemd user services to run your commands
  systemd.user.services = {
    ac-connected = {
      description = "Run command on AC connect";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'notify-send \"AC Connected\" \"Running performance commands\" && brightnessctl set 100%'";
      };
      wantedBy = [ "default.target" ];
    };
    ac-disconnected = {
      description = "Run command on AC disconnect";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'notify-send \"AC Disconnected\" \"Running battery commands\" && brightnessctl set 40%'";
      };
      wantedBy = [ "default.target" ];
    };
  };

  # services.tlp.settings = {
  #   USB_AUTOSUSPEND = 0; # disable too aggressive power-management autosuspend for USB
  #   CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #   CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  # };

}
