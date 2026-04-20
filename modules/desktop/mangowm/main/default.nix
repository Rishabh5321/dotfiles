{ ... }: {
  imports = [
    ./services.nix
    ./packages.nix
    ./wayland.nix
    ./security.nix
    ./lockscreen.nix
  ];
}
