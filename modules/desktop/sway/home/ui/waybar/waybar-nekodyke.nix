{ pkgs
, lib
, config
, ...
}:
let
  palette = if (config ? stylix && config.stylix.enable) then config.lib.stylix.colors else {
    base00 = "000000";
    base01 = "1e1e2e";
    base02 = "313244";
    base03 = "45475a";
    base04 = "585b70";
    base05 = "cdd6f4";
    base06 = "f5e0dc";
    base07 = "b4befe";
    base08 = "f38ba8";
    base09 = "fab387";
    base0A = "f9e2af";
    base0B = "a6e3a1";
    base0C = "94e2d5";
    base0D = "89b4fa";
    base0E = "cba6f7";
    base0F = "f2cdcd";
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
        modules-center = [ "sway/window" ];
        modules-left = [
          # "custom/startmenu"
          "sway/workspaces"
          "cpu"
          "memory"
          "network"
        ];
        modules-right = [
          "idle_inhibitor"
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
          font-size: 14px;
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
          background: #${palette.base00};
          border: 1px solid #${palette.base03}; /* A subtle border for definition */
          color: #${palette.base05}; /* Default text color */
          transition: ${betterTransition};
        }

        /* --- Base Module Style --- */
        /* Applies to all modules for consistency */
        #workspaces, #window, #clock, #battery, #pulseaudio, #network, #cpu, #memory, #idle_inhibitor, #tray, #custom-notification, #custom-exit, #custom-startmenu, #custom-hyprbindings {
          padding: 0px 12px; /* Horizontal padding for spacing inside the bar */
          background-color: #${palette.base01};
          margin: 4px 0px;   /* Vertical margin to center modules in the bar */
          font-weight: bold;
        }

        /* --- Hover Effects for Interactivity --- */
        #clock:hover, #battery:hover, #pulseaudio:hover, #network:hover, #cpu:hover, #memory:hover, #idle_inhibitor:hover, #custom-notification:hover {
          background-color: #${palette.base01};
        }

        /* --- Workspaces --- */
        #workspaces {
          background-color: #${palette.base01};
          margin-left: 6px;
          padding: 0 5px;
        }

        #workspaces button {
          color: #${palette.base04}; /* Inactive workspace color */
          padding: 0px 5px;
          transition: ${betterTransition};
        }

        #workspaces button:hover {
          background-color: #${palette.base02};
          color: #${palette.base06};
        }

        #workspaces button.focused {
          background-color: #${palette.base0D}; /* Use a bright accent for focus */
          color: #${palette.base00};
        }

        #workspaces button.urgent {
          background-color: #${palette.base08}; /* Use red for urgent workspaces */
          color: #${palette.base00};
        }

        /* --- Right Aligned Modules --- */
        #tray {
            margin-right: 6px; /* Add some space at the end of the bar */
        }

        /* --- State-Based Coloring for Glanceable Info --- */
        #memory.warning, #cpu.warning, #battery.warning {
          color: #${palette.base0A}; /* Yellow for warning */
        }

        #memory.critical, #cpu.critical, #battery.critical {
          color: #${palette.base08}; /* Red for critical */
        }

        #battery.charging, #battery.plugged {
          color: #${palette.base0B}; /* Green/Blue for charging */
        }

        #network.disconnected {
          color: #${palette.base08};
        }

        /* --- Specific Module Tweaks --- */
        #clock {
          color: #${palette.base0E}; /* A distinct color for the clock */
        }

        #window {
          /* The window title can be less prominent */
          color: #${palette.base04};
          font-weight: normal;
        }

        /* --- Tooltips --- */
        tooltip {
          background: #${palette.base00};
          border: 1px solid #${palette.base0B};
        }

        tooltip label {
          color: #${palette.base05};
        }
      ''
    ];
  };
}
