{ ... }: {
  # List your module files here
  imports = [
    # ./auto-upgrade.nix
    ./nh.nix
    ./nix_settings.nix
    ./pkgs.nix
    ./pkgs_stable.nix
  ];
  services.tailscale.enable = true;
}
