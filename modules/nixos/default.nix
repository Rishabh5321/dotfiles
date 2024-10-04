# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    # Include the results of the hardware scan.
    ./aagl.nix
    ./boot.nix
    ./bluetooth.nix
    ./cache.nix
    #./desktop_env.nix
    #./displaymanager.nix
    ./graphics.nix
    ./locale.nix
    ./nh.nix
    ./nix_settings.nix
    ./pkgs.nix
    ./pkgs_unstable.nix
    ./program.nix
    #./proton.nix
    ./sound.nix
    ./stylix.nix
    ./swap.nix
    #./syncthing.nix
    ./users.nix
    ./virtualisation.nix
  ];
}
