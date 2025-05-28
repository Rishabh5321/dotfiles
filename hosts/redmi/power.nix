_:
{

  # services.auto-cpufreq.enable = true;

  services.power-profiles-daemon.enable = true;

  # powerManagement.powertop.enable = true;

  # Enable thermald (only necessary if on Intel CPUs)
  services.thermald.enable = true;

  services.tlp.enable = true;

  # services.tlp.settings = {
  #   USB_AUTOSUSPEND = 0; # disable too aggressive power-management autosuspend for USB
  #   CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #   CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  # };

}
