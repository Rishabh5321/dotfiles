{ pkgs
, config
, lib
, ...
}:
let
  palette = config.stylix.base16Scheme;
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit
    (import ../../misc/variables.nix)
    clock24h
    ;
in
with lib; {
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd.target = "graphical-session.target";
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
          all-outputs = true;
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
          tooltip-format = "<big>{:%A, %d.%B %Y }</big><tt><small>{calendar}</small></tt>";
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
            warning = 25;
            critical = 10;
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
          tooltip = true;
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
    style = ''
      * {
        font-size: 16px;
        font-family: JetBrainsMono Nerd Font, FontAwesome;
        font-weight: bold;
      }
      window#waybar {
        background-color: #${palette.base00};
        border-bottom: 2px solid #${palette.base08};
        color: #${palette.base05};
      }
      #workspaces button {
        padding: 5px;
        margin: 5px;
        border-radius: 10px;
        color: #${palette.base05};
        background-color: transparent;
        transition: ${betterTransition};
      }
      #workspaces button.active {
        color: #${palette.base00};
        background-color: #${palette.base08};
      }
      #workspaces button:hover {
        color: #${palette.base00};
        background-color: #${palette.base08};
      }
      #window, #pulseaudio, #network, #idle_inhibitor, #custom-notifications, #battery, #tray, #clock, #custom-dashboard {
        padding: 0 10px;
      }
    '';
  };
}
