{ pkgs }:
pkgs.writeShellScriptBin "rofi-launcher" ''
  if pgrep -x "rofi" > /dev/null; then
    # Rofi is running, kill it
    pkill -x rofi
    exit 0
  fi

  # Launch Rofi with layer shell protocol
  rofi -show drun
''
