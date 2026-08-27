{ pkgs, ... }:

let
  wallpaper-picker = pkgs.writeShellScriptBin "wallpaper-picker" ''
    DIR="''${HOME}/Pictures/Wallpapers"
    if [ ! -d "$DIR" ]; then
      DIR="''${HOME}/Pictures"
    fi
    if [ ! -d "$DIR" ]; then
      DIR="''${HOME}"
    fi
    FILE=$(find "$DIR" -maxdepth 2 -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.gif" \) | sort | rofi -dmenu -p "Wallpaper")
    if [ -n "$FILE" ]; then
      swaymsg output '*' bg "$FILE" fill
    fi
  '';
in
{
  environment.systemPackages = [
    wallpaper-picker
  ];
}
