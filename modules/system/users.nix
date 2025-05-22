{ pkgs
, username
, ...
}: {
  #sops.secrets.ta-password.neededForUsers = true;
  users.mutableUsers = true;

  users.users = {
    "${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "Rishabh Singh";
      #hashedPasswordFile = config.sops.secrets.ta-password.path;
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
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [ ];
    };
    # "newuser" = {
    #   homeMode = "755";
    #   isNormalUser = true;
    #   description = "New user account";
    #   extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    #   shell = pkgs.bash;
    #   ignoreShellProgramCheck = true;
    #   packages = with pkgs; [];
    # };
  };

  users.groups.libvirtd.members = [ "${username}" ];
  users.extraUsers.kodi.isNormalUser = true;
  nix.settings.allowed-users = [ "${username}" ];
  location.provider = "geoclue2";
  services.geoclue2.enable = true;
}
