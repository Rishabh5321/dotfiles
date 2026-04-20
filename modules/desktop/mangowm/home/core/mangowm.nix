{ config, inputs, ... }:

let
  inherit (import ../misc/variables.nix) browser terminal extraMonitorSettings;
  modifier = "SUPER";
in
{
  imports = [
    inputs.mango.hmModules.mango
  ];

  wayland.windowManager.mango = {
    enable = true;

    extraConfig = ''
      # Monitors
      monitorrule = name:eDP-1, width:1920, height:1080, refresh:60, x:0, y:0, vrr:1
      ${extraMonitorSettings}

      # Keyboard
      xkb_rules_layout = us
      xkb_rules_options = grp:alt_shift_toggle,caps:super
      repeat_rate = 25
      repeat_delay = 600

      # Trackpad
      tap_to_click = 1
      trackpad_natural_scrolling = 1
      disable_while_typing = 1

      # Theme / Appearance
      borderpx = 2
      gappih = 2
      gappiv = 2
      gappoh = 4
      gappov = 4

      # Colors
      focuscolor = 0x${config.stylix.base16Scheme.base0D}ff
      rootcolor = 0x${config.stylix.base16Scheme.base00}ff

      # Keybindings - Applications
      bind = ${modifier}, Return, spawn, ${terminal}
      bind = ALT, Space, spawn, dms ipc call spotlight toggle
      bind = ${modifier}, V, spawn, dms ipc call clipboard toggle
      bind = ${modifier}, W, spawn, ${browser}
      bind = CTRL, L, spawn, dms ipc call lock lock

      # WM Controls
      bind = ${modifier}, Q, killclient
      bind = ${modifier}, F, togglefullscreen
      bind = ${modifier}+SHIFT, F, togglefloating
      bind = ${modifier}+SHIFT, C, quit
      bind = ${modifier}+SHIFT, R, reload_config

      # --- GLOBAL WORKSPACES ---
      # We removed the monitor index (the ', 0') from the end.
      # This allows Workspace 1-5 to exist on whichever monitor is focused.

      # Switch to Workspace
      bind = ${modifier}, 1, view, 1
      bind = ${modifier}, 2, view, 2
      bind = ${modifier}, 3, view, 3
      bind = ${modifier}, 4, view, 4
      bind = ${modifier}, 5, view, 5
      bind = ${modifier}, 6, view, 6
      bind = ${modifier}, 7, view, 7
      bind = ${modifier}, 8, view, 8
      bind = ${modifier}, 9, view, 9
      # bind = ${modifier}, 0, view, 0

      # Move Window to Workspace
      bind = ${modifier}+SHIFT, 1, tag, 1
      bind = ${modifier}+SHIFT, 2, tag, 2
      bind = ${modifier}+SHIFT, 3, tag, 3
      bind = ${modifier}+SHIFT, 4, tag, 4
      bind = ${modifier}+SHIFT, 5, tag, 5
      bind = ${modifier}+SHIFT, 6, tag, 6
      bind = ${modifier}+SHIFT, 7, tag, 7
      bind = ${modifier}+SHIFT, 8, tag, 8
      bind = ${modifier}+SHIFT, 9, tag, 9
      # bind = ${modifier}+SHIFT, 0, tag, 0

      # Switch Focus
      bind = ${modifier}, H, focusdir, left
      bind = ${modifier}, L, focusdir, right
      bind = ${modifier}, K, focusdir, up
      bind = ${modifier}, J, focusdir, down

      # 3-finger: Window focus
      gesturebind=none,left,3,focusdir,left
      gesturebind=none,right,3,focusdir,right
      gesturebind=none,up,3,focusdir,up
      gesturebind=none,down,3,focusdir,down

      # 4-finger: Workspace navigation
      gesturebind=none,left,4,viewtoright_have_client
      gesturebind=none,right,4,viewtoleft_have_client
      gesturebind=none,up,4,toggleoverview
      gesturebind=none,down,4,toggleoverview

      # Startup
      exec-once = swaync
      exec-once = systemctl --user start hyprpolkitagent
      exec-once = wl-paste --type text --watch cliphist store
      exec-once = wl-paste --type image --watch cliphist store
      exec-once = dbus-update-activation-environment --systemd --all; systemctl --user reset-failed && systemctl --user start mango-session.target
    '';
  };
}
