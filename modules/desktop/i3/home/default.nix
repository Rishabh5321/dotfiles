{ pkgs, username, host, inputs, ... }:

{
  imports = [
    # Core components
    ./core/i3.nix
    ./core/betterlockscreen.nix
    ./core/xautolock.nix

    # Services
    ./services/dunst.nix
    ./services/gnome-keyring.nix

    # UI elements
    ./ui/polybar.nix
    ./ui/rofi/rofi.nix
    ./ui/rofi/config-emoji.nix
    ./ui/rofi/config-long.nix
    ./ui/rofi/config-wallpaper.nix

    # Misc
    ./misc/emoji.nix
    ./misc/feh.nix
    ./misc/picom.nix
    ./misc/qt.nix
    ./misc/session-variables.nix
    ./misc/xdg.nix
  ];

  # Packages
  home.packages = with pkgs; [
    (import ./scripts/screenshootin.nix { inherit pkgs; })
    (import ./scripts/rofi-powermenu.nix { inherit pkgs; })
    (import ./scripts/emopicker9000.nix { inherit pkgs; })
    (import ./scripts/wall-selector.nix { inherit pkgs; })
    (import ./scripts/clipmenu.nix { inherit pkgs; })
  ];
}
