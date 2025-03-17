# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{ ... }: {
  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    ./auto-upgrade.nix
    ./bluetooth.nix
    ./boot.nix
    ./cache.nix
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
    ./dns.nix
    #./seanime.nix
  ];

}

