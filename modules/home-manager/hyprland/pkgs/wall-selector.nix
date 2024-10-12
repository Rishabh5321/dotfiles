{
  pkgs,
  wallpaperDir,
  ...
}:
pkgs.writeShellScriptBin "wallSelector" ''
  # Find all wallpapers in the directory that match the pattern "wall*"
  chosen=$(find ${wallpaperDir} -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0 | \
           xargs -0 -I{} basename "{}" | \
           ${pkgs.rofi-wayland}/bin/rofi -dmenu -p "Select a wallpaper" -config ~/.config/rofi/config-wallpaper.rasi)

  # Exit if no wallpaper was selected
  [ -z "$chosen" ] && exit;

  # Set the selected wallpaper using swww
  ${pkgs.swww}/bin/swww img ${wallpaperDir}/"$chosen"
''
