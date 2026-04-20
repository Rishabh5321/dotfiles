{ config, lib, pkgs, ... }:

let
  inherit (import ../misc/variables.nix) browser terminal extraMonitorSettings;
  modifier = "SUPER";
in
{
  xdg.configFile."mangowm/mangowm.conf".text = ''
    # Environment Variables
    env = NIXOS_OZONE_WL, 1
    env = XDG_CURRENT_DESKTOP, mangowm
    env = XDG_SESSION_TYPE, wayland
    env = XDG_SESSION_DESKTOP, mangowm
    env = GDK_BACKEND, wayland,x11
    env = QT_QPA_PLATFORM, wayland;xcb
    env = SDL_VIDEODRIVER, wayland
    env = CLUTTER_BACKEND, wayland
    env = MOZ_ENABLE_WAYLAND, 1
    env = ELECTRON_OZONE_PLATFORM_HINT, wayland

    # Startup
    exec-once = dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = swaync
    exec-once = systemctl --user start hyprpolkitagent
    exec-once = wl-paste --type text --watch cliphist store
    exec-once = wl-paste --type image --watch cliphist store

    # Monitor
    monitor = eDP-1,1920x1080@60,0x0,1
    ${extraMonitorSettings}

    # General
    general {
      gaps_in = 2
      gaps_out = 4
      border_size = 2
      col.active_border = rgb(${config.stylix.base16Scheme.base0D}) rgb(${config.stylix.base16Scheme.base0B}) 45deg
      col.inactive_border = rgb(${config.stylix.base16Scheme.base00})
    }

    # Input
    input {
      kb_layout = us
      kb_options = grp:alt_shift_toggle,caps:super
      follow_mouse = 1
      touchpad {
        natural_scroll = true
        tap-to-click = true
      }
    }

    # Keybindings
    bind = ${modifier}, Return, exec, ${terminal}
    bind = ALT, SPACE, exec, dms ipc call spotlight toggle
    bind = ${modifier}, V, exec, dms ipc call clipboard toggle
    bind = ${modifier}, W, exec, ${browser}
    bind = CTRL, L, exec, dms ipc call lock lock
    bind = ${modifier}, Q, killactive
    bind = ${modifier}, F, fullscreen
    bind = ${modifier} SHIFT, F, togglefloating
    bind = ${modifier} SHIFT, C, exit
    
    # Workspaces
    bind = ${modifier}, 1, workspace, 1
    bind = ${modifier}, 2, workspace, 2
    bind = ${modifier}, 3, workspace, 3
    bind = ${modifier}, 4, workspace, 4
    bind = ${modifier}, 5, workspace, 5
    bind = ${modifier} SHIFT, 1, movetoworkspace, 1
    bind = ${modifier} SHIFT, 2, movetoworkspace, 2
    bind = ${modifier} SHIFT, 3, movetoworkspace, 3
    bind = ${modifier} SHIFT, 4, movetoworkspace, 4
    bind = ${modifier} SHIFT, 5, movetoworkspace, 5

    # Focus
    bind = ${modifier}, h, movefocus, l
    bind = ${modifier}, l, movefocus, r
    bind = ${modifier}, k, movefocus, u
    bind = ${modifier}, j, movefocus, d
  '';
}
