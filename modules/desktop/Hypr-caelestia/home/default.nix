{ pkgs, ... }:

{
  imports = [
    # Core components
    ./core/hyprland.nix
    ./core/portal.nix

    # Services
    ./services/gnome-keyring.nix

    # UI elements
    ./ui/caelestia.nix

    # Misc
    ./misc/cursor.nix
    ./misc/swappy.nix
    ./misc/xdg.nix
    ./misc/session-variables.nix
  ];

  home.packages = import ./scripts/default.nix { inherit pkgs; } ++ [
    # Fonts used by the Caelestia shell
    pkgs.material-symbols
    pkgs.rubik
    pkgs.nerd-fonts.caskaydia-cove
  ];

  fonts.fontconfig.enable = true;
}
