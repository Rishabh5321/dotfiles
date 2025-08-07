{ pkgs, ... }:
let
  inherit (import ../misc/variables.nix) terminal browser;
in
pkgs.writeShellScriptBin "list-sway-bindings" ''
  yad --width=800 --height=650 \
  --center \
  --fixed \
  --title="Sway Keybindings" \
  --no-buttons \
  --list \
  --column=Key: \
  --column=Description: \
  --column=Command: \
  --timeout=90 \
  --timeout-indicator=right \
  " = Windows/Super/CAPS LOCK" "Modifier Key, used for keybindings" "Doesn\'t really execute anything by itself." \
  " + ENTER" "Terminal" "${terminal}" \
  "ALT + SPACE" "App Launcher" "rofi" \
  " + V" "Clipboard History" "cliphist list | rofi -dmenu | cliphist decode | wl-copy" \
  " + ALT + W" "Change Wallpaper" "wallSelector" \
  " + Q" "Kill Focused Window" "kill" \
  " + W" "Launch Web Browser" "${browser}" \
  " + SHIFT + L" "Power Menu" "wlogout" \
  " + E" "Launch Emoji Selector" "emopicker9000" \
  " + S" "Take Screenshot" "screenshootin" \
  " + D" "Launch Discord" "discord" \
  " + T" "Launch New File Browser Window" "thunar" \
  " + M" "Launch Spotify" "spotify" \
  " + P" "Toggle Split Direction" "splittoggle" \
  " + F" "Toggle Focused Fullscreen" "fullscreen" \
  " + SHIFT + F" "Toggle Focused Floating" "floating toggle" \
  " + SHIFT + C" "Quit / Exit Sway" "exit" \
  " + Left" "Move Focus To Window On The Left" "focus left" \
  " + Right" "Move Focus To Window On The Right" "focus right" \
  " + Up" "Move Focus To Window On The Up" "focus up" \
  " + Down" "Move Focus To Window On The Down" "focus down" \
  " + SHIFT + Left" "Move Focused Window Left" "move left" \
  " + SHIFT + Right" "Move Focused Window Right" "move right" \
  " + SHIFT + Up" "Move Focused Window Up" "move up" \
  " + SHIFT + Down" "Move Focused Window Down" "move down" \
  " + H" "Move Focus To Window On The Left" "focus left" \
  " + L" "Move Focus To Window On The Right" "focus right" \
  " + K" "Move Focus To Window On The Up" "focus up" \
  " + J" "Move Focus To Window On The Down" "focus down" \
  " + SHIFT + H" "Move Focused Window Left" "move left" \
  " + SHIFT + L" "Move Focused Window Right" "move right" \
  " + SHIFT + K" "Move Focused Window Up" "move up" \
  " + SHIFT + J" "Move Focused Window Down" "move down" \
  " + SPACE" "Toggle Focus Mode" "focus mode_toggle" \
  " + 1-0" "Move To Workspace 1 - 10" "workspace number X" \
  " + SHIFT + 1-0" "Move Focused Window To Workspace 1 - 10" "move container to workspace number X" \
  ""
''
