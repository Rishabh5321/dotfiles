{ ... }: {
  imports = [
    #./cache.nix
    ./display-manager.nix
    #./hardware.nix
    ./hyprland.nix
    ./pkgs.nix
    ./wayland.nix
  ];
}
