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
          font-size: 14px; /* Slightly increased for readability, adjust as needed */
          border: none;
          border-radius: 0;
          min-height: 0;
          /* Reset all margins and padding for clean slate */
          margin: 0;
          padding: 0;
        }

        /* --- The Main Bar --- */
        window#waybar {
          /* A solid background color from your stylix theme for a clean, bold look. */
          background: #${config.lib.stylix.colors.base00};
          border: 1px solid #${config.lib.stylix.colors.base03}; /* A subtle border for definition */
          border-radius: 12px; /* A more pronounced rounding for a modern look */
          color: #${config.lib.stylix.colors.base05}; /* Default text color */
          transition: ${betterTransition};
        }

        /* --- Base Module Style --- */
        /* Applies to all modules for consistency */
        #workspaces, #window, #clock, #battery, #pulseaudio, #network, #cpu, #memory, #idle_inhibitor, #tray, #custom-notification, #custom-exit, #custom-startmenu, #custom-hyprbindings {
          padding: 0px 12px; /* Horizontal padding for spacing inside the bar */
          margin: 4px 0px;   /* Vertical margin to center modules in the bar */
          font-weight: bold;
        }

        /* --- Hover Effects for Interactivity --- */
        #clock:hover, #battery:hover, #pulseaudio:hover, #network:hover, #cpu:hover, #memory:hover, #idle_inhibitor:hover, #custom-notification:hover {
          background-color: #${config.lib.stylix.colors.base01};
          border-radius: 8px; /* Give a rounded background on hover */
        }

        /* --- Workspaces --- */
        #workspaces {
          background-color: #${config.lib.stylix.colors.base01};
          border-radius: 8px;
          margin-left: 6px; /* Add some space at the beginning of the bar */
          padding: 0 5px;
        }

        #workspaces button {
          color: #${config.lib.stylix.colors.base04}; /* Inactive workspace color */
          padding: 0px 5px;
          border-radius: 8px;
          transition: ${betterTransition};
        }

        #workspaces button:hover {
          background-color: #${config.lib.stylix.colors.base02};
          color: #${config.lib.stylix.colors.base06};
        }

        #workspaces button.focused {
          background-color: #${config.lib.stylix.colors.base0D}; /* Use a bright accent for focus */
          color: #${config.lib.stylix.colors.base00};
        }

        #workspaces button.urgent {
          background-color: #${config.lib.stylix.colors.base08}; /* Use red for urgent workspaces */
          color: #${config.lib.stylix.colors.base00};
        }

        /* --- Right Aligned Modules --- */
        #tray {
            margin-right: 6px; /* Add some space at the end of the bar */
        }

        /* --- State-Based Coloring for Glanceable Info --- */
        #memory.warning, #cpu.warning, #battery.warning {
          color: #${config.lib.stylix.colors.base0A}; /* Yellow for warning */
        }

        #memory.critical, #cpu.critical, #battery.critical {
          color: #${config.lib.stylix.colors.base08}; /* Red for critical */
        }

        #battery.charging, #battery.plugged {
          color: #${config.lib.stylix.colors.base0B}; /* Green/Blue for charging */
        }

        #network.disconnected {
          color: #${config.lib.stylix.colors.base08};
        }

        /* --- Specific Module Tweaks --- */
        #clock {
          color: #${config.lib.stylix.colors.base0E}; /* A distinct color for the clock */
        }

        #window {
          /* The window title can be less prominent */
          color: #${config.lib.stylix.colors.base04};
          font-weight: normal;
        }

        /* --- Tooltips --- */
        tooltip {
          background: #${config.lib.stylix.colors.base00};
          border: 1px solid #${config.lib.stylix.colors.base0B};
          border-radius: 12px;
        }

        tooltip label {
          color: #${config.lib.stylix.colors.base05};
        }
      ''
    ];
  };
}
