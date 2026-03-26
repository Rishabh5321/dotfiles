{ lib
, pkgs
, config
, inputs
, ...
}:

let
  inherit (import ../misc/variables.nix) browser terminal extraMonitorSettings;
  modifier = "Mod";
in
{
  imports = [
    inputs.niri.homeModules.niri
  ];

  programs.niri = {
    package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
    settings = {
      spawn-at-startup = [
        { command = [ "dbus-update-activation-environment" "--all" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP" ]; }
        { command = [ "systemctl" "--user" "import-environment" "QT_QPA_PLATFORMTHEME" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP" ]; }
        { command = [ "swaync" ]; }
        { command = [ "wl-paste" "--type" "text" "--watch" "cliphist" "store" ]; }
        { command = [ "wl-paste" "--type" "image" "--watch" "cliphist" "store" ]; }
        { command = [ "systemctl" "--user" "start" "hyprpolkitagent" ]; }
      ];

      input = {
        mod-key = "Super";
        keyboard.xkb = {
          layout = "us";
          options = "grp:alt_shift_toggle,caps:super";
        };
        touchpad = {
          tap = true;
          natural-scroll = true;
          dwt = true;
        };
        mouse.accel-profile = "flat";
      };

      outputs."eDP-1" = {
        mode = { width = 1920; height = 1080; refresh = 60.0; };
        scale = 1.0;
        transform = { rotation = 0; };
        position = { x = 0; y = 0; };
      };

      layout = {
        gaps = 4;
        center-focused-column = "never";
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];
        default-column-width.proportion = 0.5;
        border = {
          width = 2;
          active = "#${config.stylix.base16Scheme.base0D}";
          inactive = "#${config.stylix.base16Scheme.base00}";
        };
        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };
      };

      window-rules = [
        {
          matches = [{ }];
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-left = 12.0;
            bottom-right = 12.0;
          };
          clip-to-geometry = true;
          focus-ring.enable = false;
        }
      ];

      binds = {
        "${modifier}+Return".action.spawn = [ terminal ];
        "Alt+Space".action.spawn = [ "dms" "ipc" "call" "spotlight" "toggle" ];
        "${modifier}+V".action.spawn = [ "dms" "ipc" "call" "clipboard" "toggle" ];
        "${modifier}+Alt+W".action.spawn = [ "wallSelector" ];
        "${modifier}+W".action.spawn = [ browser ];
        "Ctrl+L".action.spawn = [ "dms" "ipc" "call" "lock" "lock" ];
        "${modifier}+E".action.spawn = [ "wofi-emoji" ];
        "${modifier}+Shift+S".action.screenshot = [ ];
        "${modifier}+D".action.spawn = [ "discord" ];
        "${modifier}+C".action.spawn = [ "hyprpicker" "-a" ];
        "${modifier}+T".action.spawn = [ "thunar" ];
        "${modifier}+M".action.spawn = [ "spotify" ];
        "${modifier}+N".action.spawn = [ "swaync-client" "-t" "-sw" ];

        "${modifier}+Q".action.close-window = [ ];
        "${modifier}+F".action.maximize-column = [ ];
        "${modifier}+Shift+F".action.toggle-window-floating = [ ];
        "${modifier}+Shift+C".action.quit = [ ];

        "${modifier}+Left".action.focus-column-left = [ ];
        "${modifier}+Right".action.focus-column-right = [ ];
        "${modifier}+Up".action.focus-window-up = [ ];
        "${modifier}+Down".action.focus-window-down = [ ];
        "${modifier}+H".action.focus-column-left = [ ];
        "${modifier}+L".action.focus-column-right = [ ];
        "${modifier}+K".action.focus-window-up = [ ];
        "${modifier}+J".action.focus-window-down = [ ];

        "${modifier}+Shift+Left".action.move-column-left = [ ];
        "${modifier}+Shift+Right".action.move-column-right = [ ];
        "${modifier}+Shift+Up".action.move-window-up-or-to-workspace-up = [ ];
        "${modifier}+Shift+Down".action.move-window-down-or-to-workspace-down = [ ];
        "${modifier}+Shift+H".action.move-column-left = [ ];
        "${modifier}+Shift+L".action.move-column-right = [ ];
        "${modifier}+Shift+K".action.move-window-up-or-to-workspace-up = [ ];
        "${modifier}+Shift+J".action.move-window-down-or-to-workspace-down = [ ];

        "${modifier}+Ctrl+Left".action.set-column-width = "-10%";
        "${modifier}+Ctrl+Right".action.set-column-width = "+10%";
        "${modifier}+Ctrl+Up".action.set-window-height = "-10%";
        "${modifier}+Ctrl+Down".action.set-window-height = "+10%";
        "${modifier}+Ctrl+H".action.set-column-width = "-10%";
        "${modifier}+Ctrl+L".action.set-column-width = "+10%";
        "${modifier}+Ctrl+K".action.set-window-height = "-10%";
        "${modifier}+Ctrl+J".action.set-window-height = "+10%";

        "${modifier}+1".action.focus-workspace = 1;
        "${modifier}+2".action.focus-workspace = 2;
        "${modifier}+3".action.focus-workspace = 3;
        "${modifier}+4".action.focus-workspace = 4;
        "${modifier}+5".action.focus-workspace = 5;
        "${modifier}+6".action.focus-workspace = 6;
        "${modifier}+7".action.focus-workspace = 7;
        "${modifier}+8".action.focus-workspace = 8;
        "${modifier}+9".action.focus-workspace = 9;
        "${modifier}+0".action.focus-workspace = 10;

        "${modifier}+Shift+1".action.move-column-to-workspace = 1;
        "${modifier}+Shift+2".action.move-column-to-workspace = 2;
        "${modifier}+Shift+3".action.move-column-to-workspace = 3;
        "${modifier}+Shift+4".action.move-column-to-workspace = 4;
        "${modifier}+Shift+5".action.move-column-to-workspace = 5;
        "${modifier}+Shift+6".action.move-column-to-workspace = 6;
        "${modifier}+Shift+7".action.move-column-to-workspace = 7;
        "${modifier}+Shift+8".action.move-column-to-workspace = 8;
        "${modifier}+Shift+9".action.move-column-to-workspace = 9;
        "${modifier}+Shift+0".action.move-column-to-workspace = 10;

        "XF86AudioRaiseVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" ];
        "XF86AudioLowerVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" ];
        "XF86AudioMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
        "XF86AudioPlay".action.spawn = [ "playerctl" "play-pause" ];
        "XF86AudioNext".action.spawn = [ "playerctl" "next" ];
        "XF86AudioPrev".action.spawn = [ "playerctl" "previous" ];
        "XF86MonBrightnessUp".action.spawn = [ "brightnessctl" "set" "+5%" ];
        "XF86MonBrightnessDown".action.spawn = [ "brightnessctl" "set" "5%-" ];
      };
    };
  };
}
