{ ... }: {
  # List your module files here
  imports = [
    ./auto-upgrade.nix
    ./bluetooth.nix
    ./boot.nix
    #./cache.nix
    #./desktop_env.nix
    #./displaymanager.nix
    ./flatpak.nix
    ./graphics.nix
    ./kodi.nix
    ./locale.nix
    ./nh.nix
    ./nix_settings.nix
    ./pkgs.nix
    ./pkgs_stable.nix
    ./program.nix
    #./proton.nix
    ./sound.nix
    ./stylix.nix
    #./syncthing.nix
    ./swap.nix
    ./users.nix
    #./virtualisation.nix

    ./gaming.nix
    ./usbguard.nix
    ./security.nix
    #./seanime.nix
    ./upower.nix
    #./dns.nix
  ];
}

