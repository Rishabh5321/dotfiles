{ config, pkgs, username, wallpaper, ... }:
let
  rounding = 6; # Keeping this for the square UI look
in
{
  programs.hyprpanel = {
    enable = true;
    package = pkgs.hyprpanel;

    settings = {
      tear = true;
      scalingPriority = "hyprland";

      # Matugen Integration
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
          background = "rgba(0, 0, 0, 0)"; # Transparent bar background
          outer_spacing = "1.1rem";
          dropdownGap = "2.3em";

          buttons = {
            monochrome = true;
            radius = "${toString rounding}px";
            enableBorders = false;
            # Color attributes removed to let Matugen take over
          };

          menus = {
            monochrome = true;
            blur = false;
            card_radius = "${toString rounding}px";
            border = {
              radius = "${toString rounding}px";
            };
            menu.media = {
              card.tint = 90;
            };
          };
        };

        notification = {
          border_radius = "${toString rounding}px";
          blur = false;
        };

        osd = {
          # Color attributes removed
        };
      };
    };
  };
}
