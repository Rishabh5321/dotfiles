{ ... }: {
  imports = [
    ./cache.nix
    # ./hardware.nix
    ./cursor.nix
    ./services.nix
    ./packages.nix
    ./wayland.nix
    ./security.nix
    ./ly.nix
  ];
}
