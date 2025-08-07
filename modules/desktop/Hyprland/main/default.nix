{ ... }: {
  imports = [
    #./cache.nix
    ./sddm.nix
    ./hardware.nix
    ./services.nix
    ./packages.nix
    ./wayland.nix
    ./security.nix

    # ./quickshell.nix
  ];
}
