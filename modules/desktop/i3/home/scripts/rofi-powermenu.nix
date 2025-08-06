{ pkgs, ... }:

pkgs.writeShellScriptBin "rofi-powermenu" ''
  #!/bin/sh

  OPTIONS="Shutdown\nReboot\nExit\nSuspend\nLock"

  CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p "Power Menu")

  case "$CHOICE" in
    "Shutdown")
      systemctl poweroff
      ;;
    "Reboot")
      systemctl reboot
      ;;
    "Exit")
      i3-msg exit
      ;;
    "Suspend")
      systemctl suspend
      ;;
    "Lock")
      betterlockscreen -l
      ;;
  esac
''
