{ ... }: {
  imports = [
    ./cache.nix
    ./hardware.nix
    ./services.nix
    ./packages.nix
    # ./quickshell.nix
    ./wayland.nix
    ./security.nix
    ./lockscreen.nix
  ];
}
