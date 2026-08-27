{ pkgs, ... }:

let
  wallpaper-picker = pkgs.writeShellScriptBin "wallpaper-picker" ''
    DIR="/home/rishabh/Pictures/Wallpapers"
    FILE=$(find -L "$DIR" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.gif" \) | sort | while read -r img; do
      echo -en "$(basename "$img")\0icon\x1f$img\n"
    done | rofi -dmenu -show-icons -theme-str 'window { width: 800px; } listview { columns: 4; lines: 3; spacing: 20px; } element-icon { size: 150px; } element-text { horizontal-align: 0.5; } element { orientation: vertical; border-radius: 12px; }' -p "Wallpaper")
    if [ -n "$FILE" ]; then
      swaymsg output '*' bg "$DIR/$FILE" fill
    fi
  '';
in
{
  environment.systemPackages = [
    wallpaper-picker
  ];
}
