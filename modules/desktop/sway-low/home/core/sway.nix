{ lib, pkgs, ... }:

let
  swayVars = import ../misc/variables.nix;
in
with lib; {
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway;
    systemd.enable = true;
    config = rec {
      modifier = "Mod4";
      inherit (swayVars) terminal;
      menu = "rofi -show drun";

      bars = [ ];

      gaps = {
        inner = 0;
        outer = 0;
      };

      startup = [
        { command = "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"; always = true; }
        { command = "systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"; always = true; }
        { command = "waybar"; always = true; }
        { command = "nm-applet --indicator"; always = true; }
        { command = "wl-paste --type text --watch cliphist store"; always = true; }
        { command = "wl-paste --type image --watch cliphist store"; always = true; }
      ];

      keybindings = mkOptionDefault {
        "${modifier}+Return" = "exec ${swayVars.terminal}";
        "Mod1+space" = "exec rofi -show drun";
        "${modifier}+v" = "exec cliphist list | rofi -dmenu | cliphist decode | wl-copy";
        "${modifier}+w" = "exec ${swayVars.browser}";
        "Ctrl+Shift+l" = "exec wlogout";
        "${modifier}+s" = "exec grim -g \"$(slurp)\" - | wl-copy";
        "${modifier}+Alt+w" = "exec wallpaper-picker";

        "${modifier}+q" = "kill";
        "${modifier}+p" = "splittoggle";
        "${modifier}+f" = "fullscreen";
        "${modifier}+Shift+f" = "floating toggle";
        "${modifier}+Shift+c" = "exit";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        "${modifier}+space" = "focus mode_toggle";

        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
      };

      input = {
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
        "type:keyboard" = {
          xkb_layout = "us";
        };
      };

      window = {
        border = 1;
        titlebar = false;
      };

      floating = {
        border = 1;
        titlebar = false;
      };
    };
    extraConfig = ''
      set $NIXOS_OZONE_WL 1
      set $XDG_CURRENT_DESKTOP Sway
      set $XDG_SESSION_TYPE wayland
      set $XDG_SESSION_DESKTOP Sway
      set $GDK_BACKEND wayland,x11
      set $QT_QPA_PLATFORM "wayland;xcb"
      set $QT_WAYLAND_DISABLE_WINDOWDECORATION 1
      set $QT_AUTO_SCREEN_SCALE_FACTOR 1
      set $SDL_VIDEODRIVER wayland
      set $MOZ_ENABLE_WAYLAND 1
      set $WLR_RENDERER vulkan

      # Monitor Setup
      output eDP-1 pos 0 0 res 1920x1080
      output DP-1 pos 1920 0

      for_window [app_id="^pavucontrol$"] floating enable
      for_window [app_id="^blueman-manager$"] floating enable
      for_window [app_id="^nm-connection-editor$"] floating enable
    '';
  };
}
