{ ... }: {
  imports = [
    ./cache.nix
    ./hardware.nix
    ./services.nix
    ./packages.nix
    ./wayland.nix
    ./security.nix
    ./lockscreen.nix

    # ./quickshell.nix
  ];
}
