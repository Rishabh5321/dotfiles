{ ... }: {
  imports = [
    ./sddm.nix
    ./services.nix
    ./packages.nix
    ./wayland.nix
    ./security.nix
  ];
}
