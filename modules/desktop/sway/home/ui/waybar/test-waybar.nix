# waybar.nix - Nix Declarative Configuration File For Waybar Status-Bar
{ inputs, config, lib, pkgs, scripts, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd = {
      enable = true;
    };
    settings = [{
      layer = "top";
      width = 50;
      position = "left";
      # margin = "15 0 15 15";

      modules-left = [
        # "custom/nix-icon"
        "sway/workspaces"
      ];

      # modules-center = [
      #   "wlr/taskbar"
      # ];

      modules-right = [
        "tray"
        "custom/audio-icon"
        "pulseaudio/slider"
        "custom/muted-icon"
        "clock"
        "custom/power"
      ];

      "custom/nix-icon" = { format = "󱄅 "; tooltip = false; };
      "custom/audio-icon" = { format = "󰕾 "; tooltip = false; };
      "custom/muted-icon" = { format = "󰝟 "; tooltip = false; };
      "custom/power" = { format = " "; on-click = "${pkgs.wlogout}/bin/wlogout"; tooltip = false; };

      "sway/workspaces" = {
        format = "{icon}";
        format-icons = {
          default = " ";
          focused = " ";
          urgent = " ";
        };
      };

      "wlr/taskbar" = {
        format = "{icon}";
        icon-size = 24;
        spacing = 3;
        sort-by-app-id = true;
        on-click-middle = "close";
        tooltip-format = "{title}";
        on-click = "activate";
      };

      "tray" = {
        icon-size = 15;
        spacing = 10;
      };

      "clock" = {
        format = "{:%H\n%M}";
        tooltip-format = "{:%H:%M %d.%m.%y}";
      };

      "pulseaudio/slider" = {
        ignored-sinks = [ "Easy Effects Sink" ];
        min = 0;
        max = 100;
        orientation = "vertical";
      };
    }];

    style = with config.lib.stylix.colors; ''
      @define-color background #${base00};
      @define-color foreground #${base07};
      @define-color border     #${base03};
      @define-color hover      #${base02};
      @define-color selected   #${base0B};
      @define-color slider     #${base0A};
      @define-color highlight  #${base0D};
      @define-color logout     #${base08};

      @import "${./style.css}";
    '';
  };
}
