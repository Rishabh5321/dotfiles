{ config, pkgs, ... }:
let
  inherit (config.lib.stylix) colors;
  mkColor = color: "#${color}";

  background = mkColor colors.base00;
  background-alt = mkColor colors.base01;
  foreground = mkColor colors.base05;

  red = mkColor colors.base08;
  yellow = mkColor colors.base0A;
  green = mkColor colors.base0B;
  cyan = mkColor colors.base0C;
  blue = mkColor colors.base0D;
  magenta = mkColor colors.base0E;

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
            middle = [ "clock" "media" ];
            right = [ "battery" "volume" "bluetooth" "network" "systray" "notifications" ];
          };
          "1" = {
            left = [ "dashboard" "workspaces" "windowtitle" ];
            middle = [ "clock" "media" ];
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
            monochrome = false;
            text = "${foreground}";
            radius = "${toString rounding}px";
            background = "${background-alt}";
            icon = "${yellow}";
            hover = "${background}";
            workspaces = {
              hover = "${yellow}";
              active = "${green}";
              available = "${cyan}";
            };
            notifications = {
              background = "${background-alt}";
              hover = "${background}";
              total = "${red}";
              icon = "${red}";
            };
          };

          menus = {
            monochrome = false;
            background = "${background}";
            cards = "${background-alt}";
            card_radius = "${toString rounding}px";
            label = "${foreground}";
            text = "${foreground}";
            border = {
              color = "${magenta}";
              radius = "${toString rounding}px";
            };
            popover = {
              text = "${foreground}";
              background = "${background-alt}";
            };
            listitems.active = "${green}";
            icons.active = "${green}";
            switch.enabled = "${green}";
            buttons = {
              default = "${blue}";
              active = "${green}";
            };
            iconbuttons.active = "${green}";
            progressbar.foreground = "${green}";
            slider.primary = "${blue}";
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
            background = "${blue}";
            text = "${foreground}";
          };
          label = "${cyan}";
          border = "${background-alt}";
          text = "${foreground}";
          labelicon = "${cyan}";
        };

        # OSD theme
        osd = {
          bar_color = "${green}";
          bar_overflow_color = "${red}";
          icon = "${background}";
          icon_container = "${green}";
          label = "${green}";
          bar_container = "${background-alt}";
        };
      };
    };
  };
}
