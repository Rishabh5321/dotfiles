{ config, pkgs, username, wallpaper, ... }:
let
  accent = "#${config.lib.stylix.colors.base0D}";
  accent-alt = "#${config.lib.stylix.colors.base03}";
  background = "#${config.lib.stylix.colors.base00}";
  background-alt = "#${config.lib.stylix.colors.base01}";
  foreground = "#${config.lib.stylix.colors.base05}";
  rounding = 6; # More square look
in
{
  programs.hyprpanel = {
    enable = true;
    package = pkgs.hyprpanel;

    settings = {
      tear = true;
      scalingPriority = "hyprland";
      theme.matugen = true;
      wallpaper.pywal = true;
      wallpaper.enable = true;
      wallpaper.image = "/home/${username}/Pictures/Wallpapers/${wallpaper}";

      bar = {
        layouts = {
          "0" = {
            left = [ "workspaces" ];
            middle = [ ];
            right = [ "netstat" "hypridle" "battery" "volume" "bluetooth" "network" "systray" "notifications" "clock" ];
          };
          "1" = {
            left = [ "workspaces" ];
            middle = [ ];
            right = [ "netstat" "hypridle" "battery" "volume" "bluetooth" "network" "systray" "notifications" "clock" ];
          };
        };
        outer_spacing = "1.1rem";
        launcher.icon = "";
        workspaces = {
          show_numbered = true;
          show_icons = false;
        };
        windowtitle.label = false;
        clock = {
          format = "%I:%M %p";
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

      menus.clock.weather.enable = false;

      theme = {
        font.size = "0.9rem";
        font.weight = "500";

        bar = {
          background = "rgba(0, 0, 0, 0)";
          # blur = true;
          outer_spacing = "1.1rem";
          dropdownGap = "2.3em";

          buttons = {
            monochrome = true;
            text = "${foreground}";
            radius = "${toString rounding}px";
            background = "${background-alt}cc";
            icon = "${accent}";
            hover = "${accent}22"; # Soft hover
            workspaces = {
              hover = "${accent}33";
              active = "${accent}";
              available = "${accent-alt}aa";
            };
            notifications = {
              background = "${background-alt}cc";
              hover = "${accent}22";
              total = "${accent}";
              icon = "${accent}";
            };
            enableBorders = false;
          };
          menus = {
            monochrome = true;
            background = "${background}"; # Fully opaque menu
            blur = false; # No transparency for menus
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

        notification = {
          border_radius = "${toString rounding}px";
          background = "${background-alt}";
          blur = false;
          actions = {
            background = "${accent}";
            text = "${foreground}";
          };
          label = "${accent}";
          border = "${background-alt}";
          text = "${foreground}";
          labelicon = "${accent}";
        };

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
