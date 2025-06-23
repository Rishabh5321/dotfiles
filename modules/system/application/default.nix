{ ... }: {
  # List your module files here
  imports = [
    ./flatpak.nix
    ./gaming.nix
    ./kodi.nix
    ./program.nix
    #./proton.nix
  ];
}
