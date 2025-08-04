{ pkgs, username, host, inputs, ... }:
let
  vars = import ./misc/variables.nix;
in
{
  imports = [
    # Core components
    ./core/hyprland.nix
    ./core/hypridle.nix
    ./core/hyprlock.nix
    ./core/portal.nix

    # Services
    ./services/gnome-keyring.nix
    ./services/swaync.nix

    # UI elements
    ./ui/rofi/rofi.nix
    ./ui/rofi/config-emoji.nix
    ./ui/rofi/config-long.nix
    ./ui/rofi/config-wallpaper.nix
    ./ui/wlogout.nix
    # ./ui/hyprpanel.nix
    vars.waybarChoice

    # Misc
    ./misc/emoji.nix
    ./misc/qt.nix
    ./misc/swappy.nix
    ./misc/xdg.nix
    ./misc/session-variables.nix

    # Hyprland input module
    inputs.hyprland.homeManagerModules.default
  ];

  # Packages
  home.packages = import ./scripts/default.nix { inherit pkgs username host; };

  # Icons for wlogout
  home.file.".config/wlogout/icons" = {
    source = ./wlogout;
  };
}
