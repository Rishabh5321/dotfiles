{ config
, lib
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
in
with lib; {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "left";
        width = 40;
        spacing = 4;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ ];
        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "battery"
          "tray"
          "clock"
          "custom/power"
        ];

        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
          "tooltip" = "true";
        };

        "custom/launcher" = {
          "format" = "󱄅";
          "tooltip" = false;
          "on-click" = "wofi --show drun";
        };

        "hyprland/workspaces" = {
          "format" = "{icon}";
          "format-icons" = { };
          "on-click" = "activate";
          "show-special" = false;
          "all-outputs" = false;
        };

        "pulseaudio" = {
          "format" = "{icon}";
          "format-muted" = "󰝟";
          "format-icons" = {
            "headphone" = "󰋋";
            "hands-free" = "󰋋";
            "headset" = "󰋋";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "󰕿" "󰖀" "󰕾" ];
          };
          "tooltip-format" = "{volume}% {desc}";
          "on-click" = "pavucontrol";
          "on-scroll-up" = "pamixer -i 5";
          "on-scroll-down" = "pamixer -d 5";
        };

        "cpu" = {
          "format" = "󰻠";
          "tooltip-format" = "CPU: {usage}%";
          "interval" = 2;
        };

        "memory" = {
          "format" = "󰍛";
          "tooltip-format" = "RAM: {percentage}%
{used:0.1f}G/{total:0.1f}G";
          "interval" = 2;
        };

        "temperature" = {
          "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
          "format" = "󰔏";
          "tooltip-format" = "Temp: {temperatureC}°C";
          "critical-threshold" = 80;
          "format-critical" = "󰸁";
        };

        "battery" = {
          "states" = {
            "warning" = 50;
            "critical" = 15;
          };
          "format" = "{icon}";
          "format-charging" = "󰂄";
          "format-plugged" = "󰂄";
          "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          "tooltip-format" = "Battery: {capacity}%";
          "on-click" = "better-control -m -B";
        };

        "tray" = {
          "icon-size" = 16;
          "spacing" = 5;
        };

        "clock" = {
          "format" = "{:%H
%M}";
          "tooltip-format" = "{:%A %d %B %Y}";
          "on-click" = "gnome-calendar";
        };

        "custom/power" = {
          "format" = "󰐥";
          "tooltip" = "Power menu";
          "on-click" = "wlogout";
        };
      };
    };

    style = with palette; ''
      * {
        font-family: JetBrainsMono Nerd Font Mono;
        font-size: 12px;
        min-height: 0;
      }

      window#waybar {
        background: #${base00};
        color: #${base05};
        transition-property: background-color;
        transition-duration: 0.3s;
      }

      #workspaces button {
        all: unset;
        padding: 12px 0;
        margin: 2px 0;
        border-radius: 8px;
        background: transparent;
        color: #${base05};
        border: 2px solid transparent;
        font-size: 20px;
        font-weight: bold;
        transition: all 0.3s ease;
      }

      #workspaces button:hover {
        background: #${base01};
        color: #${base05};
      }

      window#waybar #workspaces button.active,
      window#waybar #workspaces button.focused,
      window#waybar #workspaces button.persistent,
      window#waybar #workspaces button.current_output {
        background: transparent;
        color: #${base05};
        border: 2px solid #${base0D};
        font-weight: bold;
      }

      #workspaces button.urgent {
        background: #${base08};
        color: #${base00};
        animation: blink 0.5s linear infinite alternate;
      }

      @keyframes blink {
        to {
          background: #${base08};
        }
      }

      #custom-launcher:hover {
        background: #${base02};
        border-radius: 8px;
      }

      #custom-power:hover {
        background: #${base02};
        border-radius: 8px;
      }

      #pulseaudio,
      #cpu,
      #memory,
      #temperature,
      #battery,
      #tray,
      #clock,
      #custom-power {
        padding: 8px 0;
        margin: 1px 0;
        background: transparent;
        color: #${base05};
        font-size: 16px;
        transition: all 0.3s ease;
      }

      #custom-launcher:hover,
      #pulseaudio:hover,
      #cpu:hover,
      #memory:hover,
      #temperature:hover,
      #battery:hover,
      #clock:hover,
      #custom-power:hover {
        background: #${base02};
      }

      #custom-launcher {
        background: transparent;
        color: #${base0E};
        font-size: 24px;
        padding: 12px 0;
      }

      #pulseaudio.muted {
        color: #${base08};
      }

      #cpu.warning,
      #memory.warning,
      #battery.warning:not(.charging) {
        color: #${base0A};
      }

      #cpu.critical,
      #memory.critical,
      #temperature.critical,
      #battery.critical:not(.charging) {
        color: #${base08};
        animation: blink 0.5s linear infinite alternate;
      }

      #battery.charging {
        color: #${base0B};
      }

      #clock {
        font-weight: bold;
        font-size: 14px;
      }

      #custom-power {
        background: transparent;
        color: #${base08};
        font-size: 20px;
        padding: 10px 0;
      }

      #tray menu {
        background: #${base00};
        border-radius: 8px;
        border: 1px solid #${base03};
      }
    '';
  };
}
