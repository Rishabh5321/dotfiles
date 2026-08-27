{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 30;
        modules-center = [ "sway/workspaces" ];
        modules-left = [
          "sway/window"
        ];
        modules-right = [
          "idle_inhibitor"
          "cpu"
          "memory"
          "pulseaudio"
          "network"
          "tray"
          "battery"
          "clock"
        ];
        "sway/workspaces" = {
          format = "{name}";
          on-click = "swaymsg workspace number {name}";
        };
        "clock" = {
          format = "{:%I:%M %p}";
          tooltip = true;
          tooltip-format = "<big>{:%A, %d %B %Y}</big>";
        };
        "sway/window" = {
          max-length = 30;
        };
        "network" = {
          interval = 2;
          format-wifi = "󰤨 {signalStrength}%";
          format-ethernet = "󰈀 {bandwidthDownBits}";
          format-disconnected = "󰤭";
          tooltip-format = "{ifname}: {ipaddr}";
        };
        "tray" = {
          spacing = 8;
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "ON";
            deactivated = "OFF";
          };
          start_activated = false;
          tooltip = true;
        };
        "cpu" = {
          format = "󰍛 {usage}%";
          tooltip = true;
        };
        "memory" = {
          format = "󰉉 {percentage}%";
          tooltip = true;
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          on-click = "pavucontrol";
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };
      }
    ];
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 13px;
        min-height: 0;
      }
      window#waybar {
        background: #1e1e2e;
        color: #cdd6f4;
      }
      #workspaces button {
        padding: 0 5px;
        color: #6c7086;
        border-radius: 3px;
      }
      #workspaces button.focused {
        color: #cdd6f4;
        background: #313244;
      }
      #window, #pulseaudio, #network, #battery, #clock {
        padding: 0 10px;
      }
      #clock {
        color: #89b4fa;
      }
      #pulseaudio {
        color: #f5c2e7;
      }
      #network {
        color: #a6e3a1;
      }
      #battery {
        color: #f9e2af;
      }
      #idle_inhibitor {
        color: #f2cdcd;
        padding: 0 10px;
        font-weight: bold;
      }
      #cpu {
        color: #cba6f7;
        padding: 0 10px;
      }
      #memory {
        color: #89dceb;
        padding: 0 10px;
      }
      #tray {
        padding: 0 8px;
      }
    '';
  };
}
