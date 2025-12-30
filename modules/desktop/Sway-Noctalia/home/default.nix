{ pkgs, username, host, ... }:
{
  imports = [
    # Core components
    ./core/sway.nix
    ./core/swayidle.nix
    # ./core/swaylock.nix
    ./core/portal.nix

    # Services
    ./services/gnome-keyring.nix

    # UI elements
    ./ui/quickshell.nix

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
