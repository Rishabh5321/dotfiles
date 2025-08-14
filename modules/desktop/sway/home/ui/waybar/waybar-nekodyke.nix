{ pkgs
, lib
, config
, ...
}:
let
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
        modules-center = [ "sway/window" ];
        modules-left = [
          # "custom/startmenu"
          "sway/workspaces"
          "cpu"
          "memory"
          "network"
          "idle_inhibitor"
        ];
        modules-right = [
          "pulseaudio"
          "battery"
          # "custom/hyprbindings"
          "custom/notification"
          "clock"
          "tray"
        ];
        "sway/workspaces" = {
          format = "{name}";
          format-icons = {
            default = " ";
            focused = " ";
            urgent = " ";
          };
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };
        "temperature" = {
          format = " {temperatureC}°C ";
        };
        "clock" = {
          format =
            if clock24h
            then '' {:L%H:%M}''
            else '' {:L%I:%M %p}'';
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
        };
        "sway/window" = {
          max-length = 30; # Increased slightly for smaller font
          separate-outputs = false;
          rewrite = {
            "" = " 🙈 No Windows? ";
          };
        };
        "memory" = {
          interval = 5;
          icon-size = 20;
          format = " {}%";
          tooltip = true;
        };
        "cpu" = {
          interval = 5;
          format = " {usage:2}%";
          tooltip = true;
        };
        "disk" = {
          format = "󱛟 {free}";
          tooltip = true;
        };
        "network" = {
          interval = 2;
          format = " {bandwidthDownBits}  {bandwidthUpBits}";
          format-ethernet = " {bandwidthDownBits}  {bandwidthUpBits}";
          format-wifi = "  {bandwidthDownBits}  {bandwidthUpBits}";
          format-disconnected = "󰤮";
          tooltip = true;
        };
        "tray" = {
          spacing = 8; # Reduced spacing
        };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
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
          scroll-step = 2;
        };
        "custom/exit" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && wlogout";
        };
        "custom/startmenu" = {
          tooltip = false;
          format = "";
          # exec = "rofi -show drun";
          #on-click = "sleep 0.1 && rofi-launcher";
          on-click = "sleep 0.1 && nwg-drawer -mb 200 -mt 200 -mr 200 -ml 200";
        };
        "custom/hyprbindings" = {
          tooltip = false;
          format = "󱕴";
          on-click = "sleep 0.1 && list-keybinds";
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = "true";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
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
      }
    ];
    style = concatStrings [
      ''
        * {
          font-family: JetBrainsMono Nerd Font;
          font-size: 13px; /* Reduced font size */
          border-radius: 0px;
          border: none;
          min-height: 0px;
        }
        window#waybar {
          background: rgba(0,0,0,0);
        }
        #workspaces {
          color: #${config.lib.stylix.colors.base00};
          background: #${config.lib.stylix.colors.base00};
          border: 1px solid #${config.lib.stylix.colors.base0B}; /* Reduced border */
          margin: 3px;
          padding: 2px;
          border-radius: 4px;
        }
        #workspaces button {
          font-weight: bold;
          padding: 0px 5px;
          margin: 0px 3px;
          border-radius: 4px; /* Made consistent */
          color: #${config.lib.stylix.colors.base0B};
          background: #${config.lib.stylix.colors.base00};
        }
        #workspaces button.focused {
          color: #${config.lib.stylix.colors.base00};
          background: #${config.lib.stylix.colors.base0B};
          transition: ${betterTransition};
        }
        #workspaces button:hover {
          font-weight: bold;
          color: #${config.lib.stylix.colors.base00};
          background: #${config.lib.stylix.colors.base0B};
          opacity: 0.8;
        }
        tooltip {
          background: #${config.lib.stylix.colors.base00};
          border: 1px solid #${config.lib.stylix.colors.base08};
          border-radius: 12px;
        }
        tooltip label {
          color: #${config.lib.stylix.colors.base08};
        }

        /* --- UNIFIED MODULE STYLE --- */
        #window, #pulseaudio, #temperature, #cpu, #memory, #idle_inhibitor, #disk,
        #custom-hyprbindings, #network, #battery, #custom-notification, #clock,
        #custom-exit, #custom-startmenu, #tray {
          font-weight: bold;
          margin: 3px 0px 3px 6px; /* Reduced margin */
          padding: 0px 10px;        /* Reduced padding */
          background: #${config.lib.stylix.colors.base00};
          color: #${config.lib.stylix.colors.base0B};
          border: 1px solid #${config.lib.stylix.colors.base0B}; /* Reduced border */
          border-radius: 4px;
        }
      ''
    ];
  };
}
