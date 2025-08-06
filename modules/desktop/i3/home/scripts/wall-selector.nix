{ pkgs, ... }:
pkgs.writeShellScriptBin "wallSelector" ''
  # Find all wallpapers in the directory that match the pattern "wall*"
  chosen=$(find ~/Pictures/Wallpapers -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0 | \
           xargs -0 -I{} basename "{}" | \
           ${pkgs.rofi}/bin/rofi -dmenu -p "Select a wallpaper" -config ~/.config/rofi/config-wallpaper.rasi)

  # Exit if no wallpaper was selected
  [ -z "$chosen" ] && exit;

  # Set the selected wallpaper using feh
  ${pkgs.feh}/bin/feh --bg-fill ~/Pictures/Wallpapers/"$chosen"
''

