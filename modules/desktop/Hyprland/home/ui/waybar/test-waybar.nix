{ hyprland
, hyprland-plugins
, config
, pkgs
, pc
, ...
}: {
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
          "tooltip-format" = "RAM: {percentage}%\n{used:0.1f}G/{total:0.1f}G";
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
          "format" = "{:%H\n%M}";
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

    style = ''
      * {
        font-family: JetBrainsMono Nerd Font Mono;
        font-size: 12px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(40, 44, 52, 0.9);
        color: #f8f8f2;
        transition-property: background-color;
        transition-duration: 0.3s;
      }

      #workspaces button {
        all: unset;
        padding: 12px 0;
        margin: 2px 0;
        border-radius: 8px;
        background: transparent;
        color: #ffffff;
        border: 2px solid transparent;
        font-size: 20px;
        font-weight: bold;
        transition: all 0.3s ease;
      }

      #workspaces button:hover {
        background: rgba(255, 255, 255, 0.1);
        color: #ffffff;
      }

      window#waybar #workspaces button.active {
        background: transparent;
        color: #ffffff;
        border: 2px solid #81a1c1;
        font-weight: bold;
      }

      window#waybar #workspaces button.focused {
        background: transparent;
        color: #ffffff;
        border: 2px solid #81a1c1;
        font-weight: bold;
      }

      window#waybar #workspaces button.persistent {
        background: transparent;
        color: #ffffff;
        border: 2px solid #81a1c1;
        font-weight: bold;
      }

      window#waybar #workspaces button.current_output {
        background: transparent;
        color: #ffffff;
        border: 2px solid #81a1c1;
        font-weight: bold;
      }

      #workspaces button.urgent {
        background: #ff5555;
        color: #f8f8f2;
        animation: blink 0.5s linear infinite alternate;
      }

      @keyframes blink {
        to {
          background: rgba(255, 85, 85, 0.5);
        }
      }

      #custom-launcher:hover {
        background: rgba(189, 147, 249, 0.2);
        border-radius: 8px;
      }

      #custom-power:hover {
        background: rgba(255, 85, 85, 0.2);
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
        color: #f8f8f2;
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
        background: rgba(98, 114, 164, 0.8);
      }

      #custom-launcher {
        background: transparent;
        color: #bd93f9;
        font-size: 24px;
        padding: 12px 0;
      }

      #pulseaudio.muted {
        color: #ff5555;
      }

      #cpu.warning {
        color: #f1fa8c;
      }

      #cpu.critical {
        color: #ff5555;
      }

      #memory.warning {
        color: #f1fa8c;
      }

      #memory.critical {
        color: #ff5555;
      }

      #temperature.critical {
        color: #ff5555;
        animation: blink 0.5s linear infinite alternate;
      }

      #battery.charging {
        color: #50fa7b;
      }

      #battery.warning:not(.charging) {
        color: #f1fa8c;
      }

      #battery.critical:not(.charging) {
        color: #ff5555;
        animation: blink 0.5s linear infinite alternate;
      }

      #clock {
        font-weight: bold;
        font-size: 14px;
      }

      #custom-power {
        background: transparent;
        color: #ff5555;
        font-size: 20px;
        padding: 10px 0;
      }

      #tray menu {
        background: rgba(40, 44, 52, 0.95);
        border-radius: 8px;
        border: 1px solid rgba(98, 114, 164, 0.3);
      }
    '';
  };
}
