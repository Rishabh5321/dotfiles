{ ... }: {
  # List your module files here
  imports = [
    ./auto-upgrade.nix
    ./bluetooth.nix
    ./boot.nix
    #./dns.nix
    ./flatpak.nix
    ./gaming.nix
    ./graphics.nix
    ./kodi.nix
    ./locale.nix
    ./nh.nix
    ./nix_settings.nix
    ./pkgs.nix
    ./pkgs_stable.nix
    ./program.nix
    #./proton.nix
    ./security.nix
    #./seanime.nix
    ./sound.nix
    ./stylix.nix
    ./swap.nix
    #./syncthing.nix
    ./usbguard.nix
    ./users.nix
    ./virtualisation.nix
  ];
}
