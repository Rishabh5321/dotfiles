{ pkgs, username, host, ... }:
{
  imports = [
    # Core components
    ./core/sway.nix
    ./core/swayidle.nix
    ./core/swaylock.nix
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
    ./ui/waybar/waybar-vertical.nix

    # Misc
    ./misc/emoji.nix
    ./misc/swappy.nix
    ./misc/xdg.nix
    ./misc/session-variables.nix
  ];

  # Packages
  home.packages = import ./scripts/default.nix { inherit pkgs username host; };

  # Icons for wlogout
  home.file.".config/wlogout/icons" = {
    source = ../../Hyprland/home/wlogout;
  };
}
