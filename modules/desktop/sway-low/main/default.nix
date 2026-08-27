{ ... }: {
  imports = [
    ./ly.nix
    ./wayland.nix
    ./hardware.nix
    ./security.nix
    ./packages.nix
    ./scripts.nix
  ];
}
