{ pkgs
, lib
, ...
}:
let
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
        # margin-top = 6;
        # margin-left = 6;
        # margin-right = 6;
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
          max-length = 22;
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
          spacing = 12;
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
          font-size: 13px; /* reduced from 16px */
          border-radius: 0px;
          border: none;
          min-height: 0px;
        }
        window#waybar {
          background: rgba(0,0,0,0);
        }
        #workspaces {
          margin: 1px 3px;
          padding: 2px 4px;
          border-radius: 4px;
        }
        #workspaces button {
          padding: 0px 4px;
          margin: 0px 2px;
        }
        #workspaces button.focused {
          min-width: 30px;
        }
        #window, #pulseaudio, #temperature, #cpu, #memory, #idle_inhibitor, #disk {
          margin: 1px 0px;
          margin-right: 5px;
          padding: 0px 8px; /* reduced from 18px */
          border-radius: 4px;
        }
        #idle_inhibitor {
          font-size: 18px; /* reduced from 28px */
        }
        #custom-hyprbindings, #network, #battery,
        #custom-notification, #clock, #custom-exit, #custom-startmenu, #tray {
          font-size: 16px; /* reduced from 20px */
          margin: 1px 0px;
          margin-right: 5px;
          padding: 0px 6px; /* reduced */
          border-radius: 4px;
        }
        tooltip {
          border-radius: 8px; /* slightly smaller */
        }
      ''
    ];
  };
}
