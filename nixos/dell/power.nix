{lib, ...}: {
  services.logind.lidSwitch = "ignore";

  services.logind.lidSwitchDocked = "ignore";

  # Disable GNOMEs power management
  #services.power-profiles-daemon.enable = false;

  # Enable thermald (only necessary if on Intel CPUs)
  services.thermald.enable = true;

  # Enable powertop
  #powerManagement.powertop.enable = true;

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
