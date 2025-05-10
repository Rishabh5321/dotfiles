_: {
  # Better scheduling for CPU cycles - thanks System76!!!
  # services.system76-scheduler.settings.cfsProfiles.enable = true;

  # Disable GNOMEs power management
  services.power-profiles-daemon.enable = true;

  # Enable powertop
  powerManagement.powertop.enable = true;

  # Enable thermald (only necessary if on Intel CPUs)
  services.thermald.enable = true;

}
