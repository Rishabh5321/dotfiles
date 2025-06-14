{ ... }: {
  imports = [
    #./cache.nix
    ./display-manager.nix
    #./hardware.nix
    ./hyprland.nix
    ./pkgs.nix
    ./wayland.nix
  ];
  security.rtkit.enable = true;
  security.sudo.enable = true;
  security.pam.services.sddm = { };
}
