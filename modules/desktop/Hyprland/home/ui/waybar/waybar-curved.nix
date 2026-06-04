{ pkgs
, lib
, config
, ...
}:
let
  stylixEnabled = config ? stylix && config.stylix.enable;
  palette = if stylixEnabled then config.stylix.base16Scheme else {
    base00 = "000000";
    base01 = "000000";
    base02 = "000000";
    base03 = "000000";
    base04 = "000000";
    base05 = "000000";
    base06 = "000000";
    base07 = "000000";
    base08 = "000000";
    base09 = "000000";
    base0A = "000000";
    base0B = "000000";
    base0C = "000000";
    base0D = "000000";
    base0E = "000000";
    base0F = "000000";
  };
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
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
          on-click = "better-control -B -m";
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
    style = lib.mkIf stylixEnabled (concatStrings [
      ''
        * {
          font-family: JetBrainsMono Nerd Font, FontAwesome;
          font-size: 16px;
          border-radius: 0px;
          border: none;
          min-height: 0px;
        }
        window#waybar {
          background: rgba(0,0,0,0);
        }
        #workspaces {
          color: #${palette.base00};
          background: #${palette.base01};
          margin: 4px;
          padding: 5px;
          border-radius: 16px;
        }
        #workspaces button {
          font-weight: bold;
          padding: 0px 5px;
          margin: 0px 3px;
          border-radius: 16px;
          color: #${palette.base00};
          background: linear-gradient(45deg, #${palette.base08}, #${palette.base0D});
          opacity: 0.5;
          transition: ${betterTransition};
        }
        #workspaces button.active {
          font-weight: bold;
          padding: 0px 5px;
          margin: 0px 3px;
          border-radius: 16px;
          color: #${palette.base00};
          background: linear-gradient(45deg, #${palette.base08}, #${palette.base0D});
          transition: ${betterTransition};
          opacity: 1.0;
          min-width: 40px;
        }
        #workspaces button:hover {
          font-weight: bold;
          border-radius: 16px;
          color: #${palette.base00};
          background: linear-gradient(45deg, #${palette.base08}, #${palette.base0D});
          opacity: 0.8;
          transition: ${betterTransition};
        }
        tooltip {
          background: #${palette.base00};
          border: 1px solid #${palette.base08};
          border-radius: 12px;
        }
        tooltip label {
          color: #${palette.base05};
        }
        #window, #pulseaudio, #network, #idle_inhibitor, #custom-notifications, #battery, #tray, #clock, #custom-dashboard {
          font-weight: bold;
          margin: 4px;
          padding: 0px 18px;
          background: #${palette.base01};
          color: #${palette.base05};
          border-radius: 16px;
        }
      ''
    ]);
  };
}
