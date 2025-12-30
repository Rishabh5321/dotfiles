{ pkgs, ... }:
pkgs.writeShellScriptBin "wallSelector" ''
  #!/usr/bin/env bash
  set -o pipefail

  WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

  if [ ! -d "$WALLPAPER_DIR" ]; then
    ${pkgs.libnotify}/bin/notify-send "Wallpaper Script Error" "Directory not found: $WALLPAPER_DIR"
    exit 1
  fi

  chosen_wallpaper=$( \
    find -L "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) \
    -printf "%p\0icon\x1f%p\n" | \
    ${pkgs.rofi}/bin/rofi -dmenu -p "Select a wallpaper" -config "$HOME/.config/rofi/config-wallpaper.rasi"
  )

  if [[ -z "$chosen_wallpaper" ]]; then
    exit 0
  fi

  exec ${pkgs.swww}/bin/swww img "$chosen_wallpaper"
''
