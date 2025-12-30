{ ... }: {
  imports = [
    ./hardware.nix
    ./lockscreen.nix
    ./services.nix
    ./packages.nix
    ./wayland.nix
    ./security.nix
  ];
}
