{ ... }: {
  imports = [
    ./cache.nix
    ./sddm.nix
    ./services.nix
    ./packages.nix
    ./wayland.nix
    ./security.nix
  ];
}
