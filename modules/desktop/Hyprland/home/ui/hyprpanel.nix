{ config, pkgs, ... }:
let
  accent = "#${config.lib.stylix.colors.base0D}";
  accent-alt = "#${config.lib.stylix.colors.base03}";
  background = "#${config.lib.stylix.colors.base00}";
  background-alt = "#${config.lib.stylix.colors.base01}";
  foreground = "#${config.lib.stylix.colors.base05}";
  rounding = 16;
in
{
  programs.hyprpanel = {
    enable = true;
    package = pkgs.hyprpanel;
    settings = {
      # General settings
      tear = true;
      scalingPriority = "hyprland";
      wallpaper.enable = true;

      # Bar settings
      bar = {
        layouts = {
          "0" = {
            left = [ "dashboard" "workspaces" "windowtitle" "netstat" "hypridle" ];
            middle = [ "clock" ];
            right = [ "battery" "volume" "bluetooth" "network" "systray" "notifications" ];
          };
          "1" = {
            left = [ "dashboard" "workspaces" "windowtitle" "netstat" ];
            middle = [ "clock" ];
            right = [ "volume" "network" "systray" "notifications" ];
          };
        };
        outer_spacing = "1rem";
        launcher.icon = "";
        workspaces = {
          show_numbered = true;
          show_icons = false;
        };
        windowtitle.label = false;
        clock = {
          format = "%I:%M:%S %p";
          showIcon = false;
        };
        volume.label = true;
        bluetooth.label = false;
        network = {
          label = true;
          truncation_size = 30;
        };
        media.show_active_only = true;
        customModules.updates.pollingInterval = 1440000;
      };

      # Menus settings
      menus.clock.weather.enable = false;

      # Theme settings
      theme = {
        font.size = "0.85rem";

        # Bar theme
        bar = {
          background = "rgba(0, 0, 0, 0.3)";
          outer_spacing = "1rem";
          dropdownGap = "2.3em";

          buttons = {
            monochrome = true;
            text = "${foreground}";
            radius = "${toString rounding}px";
            background = "${background-alt}";
            icon = "${accent}";
            hover = "${background}";
            workspaces = {
              hover = "${accent-alt}";
              active = "${accent}";
              available = "${accent-alt}";
            };
            notifications = {
              background = "${background-alt}";
              hover = "${background}";
              total = "${accent}";
              icon = "${accent}";
            };
          };

          menus = {
            monochrome = true;
            background = "${background}";
            cards = "${background-alt}";
            card_radius = "${toString rounding}px";
            label = "${foreground}";
            text = "${foreground}";
            border = {
              color = "${accent}";
              radius = "${toString rounding}px";
            };
            popover = {
              text = "${foreground}";
              background = "${background-alt}";
            };
            listitems.active = "${accent}";
            icons.active = "${accent}";
            switch.enabled = "${accent}";
            buttons = {
              default = "${accent}";
              active = "${accent}";
            };
            iconbuttons.active = "${accent}";
            progressbar.foreground = "${accent}";
            slider.primary = "${accent}";
            tooltip = {
              background = "${background-alt}";
              text = "${foreground}";
            };
            dropdownmenu = {
              background = "${background-alt}";
              text = "${foreground}";
            };
            menu.media = {
              background.color = "${background-alt}";
              card.color = "${background-alt}";
              card.tint = 90;
            };
          };
        };

        # Notification theme
        notification = {
          border_radius = "${toString rounding}px";
          background = "${background-alt}";
          actions = {
            background = "${accent}";
            text = "${foreground}";
          };
          label = "${accent}";
          border = "${background-alt}";
          text = "${foreground}";
          labelicon = "${accent}";
        };

        # OSD theme
        osd = {
          bar_color = "${accent}";
          bar_overflow_color = "${accent-alt}";
          icon = "${background}";
          icon_container = "${accent}";
          label = "${accent}";
          bar_container = "${background-alt}";
        };
      };
    };
  };
}
