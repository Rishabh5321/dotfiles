_: {
  services.logind.settings.Login.HandleLidSwitch = "ignore";

  services.logind.settings.Login.HandleLidSwitchDocked = "ignore";

  # Disable GNOMEs power management
  # services.power-profiles-daemon.enable = true;

  # Enable thermald (only necessary if on Intel CPUs)
  services.thermald.enable = true;

  # Enable powertop
  #powerManagement.powertop.enable = true;

  #services.xserver.displayManager.gdm = {
  #  enable = true;
  #  autoSuspend = false;
  #};

  # powerManagement.enable = true;
  # powerManagement.cpuFreqGovernor = "performance";

}
