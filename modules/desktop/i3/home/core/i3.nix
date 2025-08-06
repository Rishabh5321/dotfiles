{ pkgs, wallpaper, wallpapers, ... }:

let
  modifier = "Mod4"; # Use the Super key as the modifier
  browser = "firefox"; # Set default browser
  terminal = "ghostty"; # Set default terminal
in
{
  xsession.enable = true;

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;

    config = {
      modifier = modifier;
      gaps = {
        inner = 4;
        outer = 8;
      };
      window = {
        border = 2;
        titlebar = false; # Hyprland doesn't have titlebars by default
      };
      bars = [];
      # colors = {
      #   background = "#${config.stylix.base16Scheme.base00}";
      #   focused = {
      #     border = "#${config.stylix.base16Scheme.base0D}";
      #     background = "#${config.stylix.base16Scheme.base0D}";
      #     text = "#${config.stylix.base16Scheme.base00}";
      #     indicator = "#${config.stylix.base16Scheme.base0B}";
      #     childBorder = "#${config.stylix.base16Scheme.base0D}";
      #   };
      #   unfocused = {
      #     border = "#${config.stylix.base16Scheme.base00}";
      #     background = "#${config.stylix.base16Scheme.base00}";
      #     text = "#${config.stylix.base16Scheme.base05}";
      #     indicator = "#${config.stylix.base16Scheme.base00}";
      #     childBorder = "#${config.stylix.base16Scheme.base00}";
      #   };
      # };

      keybindings = {
        "${modifier}+Return" = "exec ${terminal}";
        "Mod1+space" = "exec rofi -show drun";
        "${modifier}+v" = "exec copyq toggle";
        "${modifier}+Alt+w" = "exec wallSelector";
        "${modifier}+w" = "exec ${browser}";
        "${modifier}+Shift+l" = "exec rofi-powermenu";
        "${modifier}+e" = "exec emopicker9000";
        "${modifier}+s" = "exec screenshootin";
        "${modifier}+d" = "exec discord";
        "${modifier}+c" = "exec gpick"; # gpick as a replacement for hyprpicker
        "${modifier}+t" = "exec thunar";
        "${modifier}+m" = "exec spotify";

        "${modifier}+q" = "kill";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+Shift+f" = "floating toggle";
        "${modifier}+Shift+c" = "exit";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        # "${modifier}+Shift+l" = "move right";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

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

      startup = [
        { command = "nm-applet --indicator"; always = true; }
        { command = "kdeconnect-indicator"; always = true; }
        { command = "dunst"; always = true; }
        { command = "feh --bg-fill ${wallpapers}/${wallpaper}"; always = true; }
        { command = "xsetroot -cursor_name left_ptr"; always = true; }
        { command = "systemctl --user start polkit-gnome-authentication-agent-1"; always = true; }
        { command = "/usr/lib/xdg-desktop-portal-gtk"; always = true; }
        { command = "copyq"; always = true; }
      ];
    };
    extraConfig = ''
      for_window [class="^(org.kde.polkit-kde-authentication-agent-1)$"] floating enable
      for_window [class="^(xdg-desktop-portal-gtk)$"] floating enable
    '';
  };
}
