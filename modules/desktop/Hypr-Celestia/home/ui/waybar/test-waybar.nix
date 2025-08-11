{ lib
, config
, ...
}:
let
  palette = config.stylix.base16Scheme;
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
in
with lib; {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 35;

        # Following SimpleBlueColorWaybar layout
        modules-left = [ "custom/nixos" "custom/minimized" "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "idle_inhibitor" "pulseaudio" "bluetooth" "cpu" "memory" "temperature" "hyprland/language" "network" "custom/logout" ];

        # logo
        "custom/nixos" = {
          format = "";
          tooltip = "Nixos Beauty";
        };

        # Hyprland workspaces
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{name}";
          format-icons = {
            "urgent" = "";
            "active" = "";
            "default" = "";
          };
        };

        # Tray
        tray = {
          spacing = 10;
          icon-size = 16;
        };

        # Idle inhibitor
        idle_inhibitor = {
          format = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };

        # PulseAudio
        pulseaudio = {
          "format" = "{icon}  {volume}%";
          "format-bluetooth" = "{icon} {volume}%  {format_source}";
          "format-bluetooth-muted" = " {icon} {format_source}";
          "format-muted" = " {format_source}";
          "format-source" = " {volume}%";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };

        bluetooth = {
          "format" = " {status}";
          "format-connected" = " {device_alias}";
          "format-connected-battery" = " {device_alias} {device_battery_percentage}%";
          "tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          "tooltip-format-enumerate-connected-battery" = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          "on-click" = "blueman-manager";
          "on-click-right" = "bluetuith";
        };

        # Clock (centered)
        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%A, %d %B %Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        # CPU usage
        cpu = {
          format = "  {usage}%";
          tooltip = true;
        };

        # Memory usage
        memory = {
          format = " {}%";
          tooltip = true;
        };

        # Temperature
        temperature = {
          interval = 10;
          hwmon-path = "/sys/class/thermal/thermal_zone0/temp";
          critical-threshold = 100;
          format-critical = "  {temperatureC}";
          format = "  {temperatureC}°C";
        };

        # Hyprland language
        "hyprland/language" = {
          format = "   {}";
          format-en = "EN";
        };

        # Network (with better styling)
        network = {
          "format-wifi" = "   {essid} ({signalStrength}%)";
          "format-ethernet" = "{ipaddr}/{cidr} ";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "format-linked" = "{ifname} (No IP) ";
          "format-disconnected" = "Disconnected ⚠";
        };

        # Logout action
        "custom/logout" = {
          format = "⏻";
          tooltip = "Power Menu";
          on-click = "wlogout";
        };

        # Minimized windows indicator
        "custom/minimized" = {
          format = "󱂬 ";
          return-type = "json";
          interval = 2;
          exec = "bash -c 'count=$(hyprctl clients -j | jq -r \"[.[] | select(.workspace.name == \\\"special:minimized\\\")] | length\"); if [ \"$count\" -eq 0 ]; then echo \"{\\\"text\\\": \\\"\\\", \\\"tooltip\\\": \\\"No minimized windows\\\", \\\"class\\\": \\\"empty\\\"}\"; else echo \"{\\\"text\\\": \\\"  $count\\\", \\\"tooltip\\\": \\\"$count minimized windows\\nClick to toggle view\\nShift+Click to restore all\\\", \\\"class\\\": \\\"minimized\\\"}\"; fi'";
          on-click = "hyprctl dispatch togglespecialworkspace minimized";
          on-click-right = "hyprctl dispatch movetoworkspacesilent e+0 && hyprctl dispatch togglespecialworkspace minimized";
          tooltip = true;
        };
      };
    };

    style = concatStrings [
      ''
        /* Stylix-themed Waybar configuration */
        * {
          font-family:"CaskaydiaCove Nerd Font", sans-serif;
          font-size: 12px;
          transition: ${betterTransition};
          min-height: 0;
        }

        window#waybar {
          background: transparent;
          transition-property: background-color;
          transition-duration: .3s;
        }

        .modules-left,
        .modules-center,
        .modules-right {
          background: #${palette.base01};
          opacity: 0.9;
          margin: 5px 10px;
          padding: 4px;
          border-radius: 8px;
          border: 1px solid #${palette.base03};
        }

        .modules-center {
          padding: 0px;
        }

        #clock,
        #cpu,
        #memory,
        #temperature,
        #network,
        #pulseaudio,
        #bluetooth,
        #idle_inhibitor,
        #language,
        #tray,
        #custom-logout,
        #custom-minimized {
          padding: 8px;
          border-radius: 6px;
          margin: 0 2px;
          color: #${palette.base05};
        }

        #clock:hover,
        #cpu:hover,
        #memory:hover,
        #temperature:hover,
        #network:hover,
        #pulseaudio:hover,
        #bluetooth:hover,
        #idle_inhibitor:hover,
        #language:hover,
        #tray:hover,
        #custom-logout:hover,
        #custom-minimized:hover {
          background: #${palette.base0D};
          opacity: 0.2;
          border-radius: 6px;
        }

        #workspaces button {
          background: transparent;
          font-weight: 900;
          color: #${palette.base05};
          border: none;
          border-radius: 6px;
          margin: 0 2px;
          padding: 4px 8px;
        }

        #workspaces button.active {
          background: linear-gradient(45deg, #${palette.base08}, #${palette.base0D});
          color: #${palette.base00};
        }

        #workspaces button:hover {
          background: #${palette.base0D};
          opacity: 0.3;
          color: #${palette.base05};
          box-shadow: none;
        }

        #custom-nixos {
          margin: 0px 5px;
          padding: 4px;
          font-size: 16px;
          transition: color .3s;
          color: #${palette.base0A};
        }

        #custom-nixos:hover {
          color: #${palette.base0D};
        }

        #cpu {
          color: #${palette.base05};
        }

        #memory {
          color: #${palette.base05};
        }

        #temperature {
          color: #${palette.base05};
        }

        #network {
          color: #${palette.base05};
        }

        #pulseaudio {
          color: #${palette.base05};
        }

        #idle_inhibitor {
          color: #${palette.base05};
        }

        #language {
          color: #${palette.base05};
        }

        #custom-logout {
          color: #${palette.base08};
          font-weight: bold;
          padding: 8px;
          border-radius: 50%;
        }

        #custom-logout:hover {
          background: #${palette.base08};
          opacity: 0.2;
        }

        #clock {
          font-weight: bold;
          color: #${palette.base0D};
        }

        /* Temperature warning states */
        #temperature.critical {
          color: #${palette.base08};
        }

        /* Network states */
        #network.disconnected {
          color: #${palette.base08};
        }

        /* Audio states */
        #pulseaudio.muted {
          color: #${palette.base04};
        }

        /* Idle inhibitor states */
        #idle_inhibitor.activated {
          color: #${palette.base0B};
        }

        #idle_inhibitor.deactivated {
          color: #${palette.base04};
        }

        /* Bluetooth states */
        #bluetooth {
          color: #${palette.base05};
        }

        #bluetooth.on {
          color: #${palette.base0D};
        }

        #bluetooth.connected {
          color: #${palette.base0B};
        }

        #bluetooth.off {
          color: #${palette.base03};
        }

        #bluetooth.disabled {
          color: #${palette.base03};
        }

        #bluetooth.discoverable {
          color: #${palette.base0A};
        }

        /* Minimized windows indicator */
        #custom-minimized {
          color: #${palette.base0D};
          font-weight: bold;
        }

        #custom-minimized:hover {
          background: #${palette.base0D};
          opacity: 0.2;
        }

        #custom-minimized.empty {
          color: #${palette.base03};
        }

        tooltip {
          background: #${palette.base00};
          border: 1px solid #${palette.base08};
          border-radius: 12px;
        }

        tooltip label {
          color: #${palette.base05};
        }
      ''
    ];
  };
}
