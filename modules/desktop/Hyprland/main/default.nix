{ ... }: {
  imports = [
    ./cache.nix
    ./display-manager.nix
    ./hardware.nix
    ./hyprland.nix
    ./pkgs.nix
    ./portal.nix
    ./wayland.nix
  ];
}
