{ pkgs, username, ... }: {
  # Allow user management outside the Nix store
  users.mutableUsers = true;

  # Define user configuration
  users.users.${username} = {
    isNormalUser = true;
    description = "Rishabh Singh";

    # Home directory permissions
    homeMode = "755";

    # Add user to necessary groups
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "scanner"
      "lp"
      "adbusers"
      "docker"
      "kvm"
      "video"
      "qemu-libvirtd"
      "sambashare"
    ];

    # Set default shell to zsh
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };

  # Add user to the libvirtd group explicitly
  users.groups.libvirtd.members = [ "${username}" ];

  # Create an extra user for Kodi (required for Kodi service)
  users.extraUsers.kodi.isNormalUser = true;

  # Allow the user to run nix commands
  nix.settings.allowed-users = [ "${username}" ];

  # Enable location services via Geoclue2
  location.provider = "geoclue2";
  services.geoclue2.enable = true;
}
