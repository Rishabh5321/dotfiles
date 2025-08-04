{ pkgs
, lib
, config
, ...
}:
let
  palette = config.stylix.base16Scheme;
  inherit (import ../../misc/variables.nix) clock24h;
in
with lib; {
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-center = [ "hyprland/workspaces" ];
        modules-left = [
          "custom/dashboard"
          "hyprland/window"
          "network"
        ];
        modules-right = [
          "idle_inhibitor"
          "custom/notifications"
          "pulseaudio"
          "battery"
          "tray"
          "clock"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          format-icons = {
            default = " ";
            active = " ";
            urgent = " ";
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        "clock" = {
          format =
            if clock24h
            then ''{:%H:%M}''
            else ''{:%I:%M %p}'';
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
        };
        "hyprland/window" = {
          max-length = 25;
          separate-outputs = false;
          rewrite = {
            "" = "Desktop";
          };
        };
        "network" = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-ethernet = " {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };
        "tray" = {
          spacing = 12;
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{volume}% {icon}";
          format-bluetooth-muted = "";
          format-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "sleep 0.1 && pavucontrol";
        };
        "custom/notifications" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "";
            none = "";
            dnd-notification = "";
            dnd-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && task-waybar";
          escape = true;
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          on-click = "";
          tooltip = false;
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        "custom/dashboard" = {
          format = "";
          on-click = "rofi -show drun";
        };
      }
    ];
    style = concatStrings [
      ''
        * {
          font-family: JetBrainsMono Nerd Font, FontAwesome;
          font-size: 14px;
          border-radius: 0px;
          border: none;
          min-height: 0px;
        }
        window#waybar {
          background: #${palette.base00};
          color: #${palette.base05};
        }
        #workspaces button {
          padding: 0px 5px;
          background: transparent;
          color: #${palette.base04};
        }
        #workspaces button.active {
          color: #${palette.base08};
        }
        #workspaces button:hover {
          color: #${palette.base08};
        }
        tooltip {
          background: #${palette.base00};
          border: 1px solid #${palette.base05};
          border-radius: 12px;
        }
        tooltip label {
          color: #${palette.base05};
        }
        #window, #pulseaudio, #network, #idle_inhibitor, #custom-notifications, #battery, #tray, #clock, #custom-dashboard {
          padding: 0px 10px;
        }
      ''
    ];
  };
}
