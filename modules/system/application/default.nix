{ ... }: {
  # List your module files here
  imports = [
    ./flatpak.nix
    ./gaming.nix
    # ./kodi.nix
    ./lossless.nix
    ./program.nix
    #./proton.nix
    ./services.nix
  ];
}
