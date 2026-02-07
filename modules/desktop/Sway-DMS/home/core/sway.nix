{ lib, pkgs, ... }:

let
  swayVars = import ../misc/variables.nix; # Super key
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

      bars = [ ]; # Use waybar instead

      gaps = {
        inner = 0;
        outer = 0;
      };

      startup = [
        { command = "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"; always = true; }
        { command = "systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"; always = true; }
        # { command = "dms run"; always = true; }
        # { command = "swww-daemon"; always = true; }
        { command = "swaync"; always = true; }
        { command = "nm-applet --indicator"; always = true; }
        # { command = "waybar"; always = true; }
        { command = "kdeconnect-indicator"; always = true; }
        { command = "wl-paste --type text --watch cliphist store"; always = true; }
        { command = "wl-paste --type image --watch cliphist store"; always = true; }
        { command = "systemctl --user import-environment SWAYSOCK WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"; always = true; }
        { command = "dbus-update-activation-environment --systemd --all"; always = true; }
        # { command = "sleep 10 && swww img ${wallpapers}/${wallpaper}"; always = true; }

        # Open apps on specific workspaces
        { command = "swaymsg 'workspace number 1; exec zen'"; always = true; }
        { command = "swaymsg 'workspace number 2; exec obsidian'"; always = true; }
        { command = "swaymsg 'workspace number 3; exec brave'"; always = true; }
        { command = "swaymsg 'workspace number 4; exec blueman-manager'"; always = true; }
        { command = "swaymsg 'workspace number 5; exec discord & Telegram'"; always = true; }
      ];

      keybindings = mkOptionDefault {
        "${modifier}+Return" = "exec ${swayVars.terminal}";
        "Mod1+space" = "exec dms ipc call spotlight toggle";
        "${modifier}+v" = "exec dms ipc call clipboard toggle";
        "${modifier}+Alt+w" = "exec wallSelector";
        "${modifier}+w" = "exec ${swayVars.browser}";
        "Ctrl+l" = "exec dms ipc call lock lock";
        "${modifier}+e" = "exec dms ipc call spotlight toggleQuery ':' ";
        "${modifier}+s" = "exec screenshootin";
        "${modifier}+d" = "exec discord";
        "${modifier}+c" = "exec hyprpicker -a"; # hyprpicker works on sway too
        "${modifier}+t" = "exec thunar";
        "${modifier}+m" = "exec spotify";

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
        "XF86AudioPause" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
      };

      input = {
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          dwt = "enabled"; # disable while typing
        };
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_options = "grp:alt_shift_toggle,caps:super";
        };
      };

      window = {
        border = 2;
        titlebar = false;
      };

      floating = {
        border = 2;
        titlebar = true;
      };
    };
    extraConfig = ''
      # Environment Variables
      exec dbus-update-activation-environment --systemd \
          XDG_CURRENT_DESKTOP \
          XDG_SESSION_TYPE \
          XDG_SESSION_DESKTOP \
          QT_QPA_PLATFORM \
          MOZ_ENABLE_WAYLAND

      set $NIXOS_OZONE_WL 1
      set $XDG_CURRENT_DESKTOP sway

      # Monitor Setup
      output eDP-1 pos 0 0 res 1920x1080
      ${swayVars.extraMonitorSettings}

      # Window Rules
      for_window [app_id="^org.kde.polkit-kde-authentication-agent-1$"] floating enable
      for_window [app_id="^xdg-desktop-portal-gtk$"] floating enable
      for_window [app_id="^pavucontrol$"] floating enable
      for_window [app_id="^blueman-manager$"] floating enable
      for_window [app_id="^nm-connection-editor$"] floating enable

      # Idle inhibition rules
      for_window [app_id="^mpv|vlc|kodi|.+exe$"] inhibit_idle focus
      for_window [app_id="^firefox|${swayVars.browser}$"] inhibit_idle fullscreen

      # Remove gaps when only one window is present on workspace
      for_window [tiling] border pixel 2
      for_window [tiling] gaps inner 4
      for_window [tiling] gaps outer 8
      smart_gaps on
      smart_borders on
    '';
  };
}
