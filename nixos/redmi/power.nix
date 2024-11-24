{ pkgs, inputs, ... }: {
  # Better scheduling for CPU cycles - thanks System76!!!
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  # Disable GNOMEs power management
  # services.power-profiles-daemon.enable = false;

  # Enable powertop
  #powerManagement.powertop.enable = true;

  # Enable thermald (only necessary if on Intel CPUs)
  services.thermald.enable = true;

  services.logind.lidSwitch = "suspend";

  services.logind.lidSwitchDocked = "ignore";

  environment.systemPackages = [
    # or home.packages
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge # installs a package
  ];

}
