{ lib
, pkgs
, config
, ...
}:

let
  inherit (import ../misc/variables.nix) browser terminal extraMonitorSettings;
  modifier = "Mod";
in
{
  xdg.configFile."niri/config.kdl".text = ''
    spawn-at-startup "dbus-update-activation-environment" "--all" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP"
    spawn-at-startup "systemctl" "--user" "import-environment" "QT_QPA_PLATFORMTHEME" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP"
    spawn-at-startup "swaync"
    spawn-at-startup "wl-paste" "--type" "text" "--watch" "cliphist" "store"
    spawn-at-startup "wl-paste" "--type" "image" "--watch" "cliphist" "store"
    spawn-at-startup "systemctl" "--user" "start" "hyprpolkitagent"

    input {
        keyboard {
            xkb {
                layout "us"
                options "grp:alt_shift_toggle,caps:super"
            }
        }
        touchpad {
            tap
            natural-scroll
            dwt
        }
        mouse {
            accel-profile "flat"
        }
    }

    output "eDP-1" {
        mode "1920x1080@60"
        scale 1.0
        transform "normal"
        position x=0 y=0
    }

    layout {
        gaps 4
        center-focused-column "never"
        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }
        default-column-width { proportion 0.5; }
        focus-ring {
            off
        }
        border {
            width 2
            active-color "#${config.stylix.base16Scheme.base0D}"
            inactive-color "#${config.stylix.base16Scheme.base00}"
        }
        struts {
            left 0
            right 0
            top 0
            bottom 0
        }
    }

    window-rule {
        geometry-corner-radius 12
        clip-to-geometry true
    }

    binds {
        // Mod+Return: Terminal
        "${modifier}+Return" { spawn "${terminal}"; }
        "Alt+Space" { spawn "dms" "ipc" "call" "spotlight" "toggle"; }
        "${modifier}+V" { spawn "dms" "ipc" "call" "clipboard" "toggle"; }
        "${modifier}+Alt+W" { spawn "wallSelector"; }
        "${modifier}+W" { spawn "${browser}"; }
        "Ctrl+L" { spawn "dms" "ipc" "call" "lock" "lock"; }
        "${modifier}+E" { spawn "wofi-emoji"; }
        "${modifier}+Shift+S" { screenshot-area; }
        "${modifier}+D" { spawn "discord"; }
        "${modifier}+C" { spawn "hyprpicker" "-a"; }
        "${modifier}+T" { spawn "thunar"; }
        "${modifier}+M" { spawn "spotify"; }
        "${modifier}+N" { spawn "swaync-client" "-t" "-sw"; }

        "${modifier}+Q" { close-window; }
        "${modifier}+F" { maximize-column; }
        "${modifier}+Shift+F" { toggle-window-floating; }
        "${modifier}+Shift+C" { quit; }
        "${modifier}+Shift+P" { pin-window; }

        // Movement
        "${modifier}+Left"  { focus-column-left; }
        "${modifier}+Right" { focus-column-right; }
        "${modifier}+Up"    { focus-window-up; }
        "${modifier}+Down"  { focus-window-down; }
        "${modifier}+H"     { focus-column-left; }
        "${modifier}+L"     { focus-column-right; }
        "${modifier}+K"     { focus-window-up; }
        "${modifier}+J"     { focus-window-down; }

        "${modifier}+Shift+Left"  { move-column-left; }
        "${modifier}+Shift+Right" { move-column-right; }
        "${modifier}+Shift+Up"    { move-window-up-or-to-workspace-above; }
        "${modifier}+Shift+Down"  { move-window-down-or-to-workspace-below; }
        "${modifier}+Shift+H"     { move-column-left; }
        "${modifier}+Shift+L"     { move-column-right; }
        "${modifier}+Shift+K"     { move-window-up-or-to-workspace-above; }
        "${modifier}+Shift+J"     { move-window-down-or-to-workspace-below; }

        // Resizing
        "${modifier}+Ctrl+Left"  { set-column-width "-10%"; }
        "${modifier}+Ctrl+Right" { set-column-width "+10%"; }
        "${modifier}+Ctrl+Up"    { set-window-height "-10%"; }
        "${modifier}+Ctrl+Down"  { set-window-height "+10%"; }
        "${modifier}+Ctrl+H"     { set-column-width "-10%"; }
        "${modifier}+Ctrl+L"     { set-column-width "+10%"; }
        "${modifier}+Ctrl+K"     { set-window-height "-10%"; }
        "${modifier}+Ctrl+J"     { set-window-height "+10%"; }

        // Workspaces
        "${modifier}+1" { focus-workspace 1; }
        "${modifier}+2" { focus-workspace 2; }
        "${modifier}+3" { focus-workspace 3; }
        "${modifier}+4" { focus-workspace 4; }
        "${modifier}+5" { focus-workspace 5; }
        "${modifier}+6" { focus-workspace 6; }
        "${modifier}+7" { focus-workspace 7; }
        "${modifier}+8" { focus-workspace 8; }
        "${modifier}+9" { focus-workspace 9; }
        "${modifier}+0" { focus-workspace 10; }

        "${modifier}+Shift+1" { move-column-to-workspace 1; }
        "${modifier}+Shift+2" { move-column-to-workspace 2; }
        "${modifier}+Shift+3" { move-column-to-workspace 3; }
        "${modifier}+Shift+4" { move-column-to-workspace 4; }
        "${modifier}+Shift+5" { move-column-to-workspace 5; }
        "${modifier}+Shift+6" { move-column-to-workspace 6; }
        "${modifier}+Shift+7" { move-column-to-workspace 7; }
        "${modifier}+Shift+8" { move-column-to-workspace 8; }
        "${modifier}+Shift+9" { move-column-to-workspace 9; }
        "${modifier}+Shift+0" { move-column-to-workspace 10; }

        // Mouse
        "${modifier}+MouseLeft" { drag-window; }

        // Media keys
        "XF86AudioRaiseVolume" { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        "XF86AudioLowerVolume" { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        "XF86AudioMute"        { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        "XF86AudioPlay"        { spawn "playerctl" "play-pause"; }
        "XF86AudioNext"        { spawn "playerctl" "next"; }
        "XF86AudioPrev"        { spawn "playerctl" "previous"; }
        "XF86MonBrightnessUp"   { spawn "brightnessctl" "set" "+5%"; }
        "XF86MonBrightnessDown" { spawn "brightnessctl" "set" "5%-"; }
    }
  '';
}
