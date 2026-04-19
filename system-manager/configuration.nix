{ pkgs
, system
, ...
}:

{
  imports = [
    ../modules/system/packages/nix_settings.nix
    ./modules/pam.nix
  ];

  config = {
    nixpkgs.hostPlatform = system;
    system-manager.allowAnyDistro = true;

    environment.systemPackages = with pkgs; [
      gh
      # System-level CLI tools
      vim
      pciutils
      usbutils
      curl
    ];

    # Automate the Polkit/Auth fix from your README
    systemd.tmpfiles.rules = [
      "L+   /run/wrappers/bin/unix_chkpwd -    -    -   -   /usr/bin/unix_chkpwd"
    ];

    system-manager.pam = {
      enable = true;
      services = [ "hyprlock" "swaylock" "sway" "hyprland" ];
    };
  };
}
