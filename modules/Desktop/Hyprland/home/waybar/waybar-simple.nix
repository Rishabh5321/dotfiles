{
  pkgs,
  lib,
  host,
  config,
  ...
}: let
  inherit (import ../variables.nix) clock24h;
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
          modules-center = ["hyprland/workspaces"];
          modules-left = [
            "custom/startmenu"
            "custom/arrow6"
            "pulseaudio"
            "cpu"
            "memory"
            "idle_inhibitor"
            "custom/arrow7"
            "hyprland/window"
          ];
          modules-right = [
            "custom/arrow4"
            "custom/hyprbindings"
            "custom/arrow3"
            "custom/notification"
            "custom/arrow3"
            "custom/exit"
            "battery"
            "custom/arrow2"
            "tray"
            "custom/arrow1"
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
              if clock24h == true
              then '' {:L%H:%M}''
              else '' {:L%I:%M %p}'';
            tooltip = true;
            tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
          };
          "hyprland/window" = {
            max-length = 22;
            separate-outputs = false;
            rewrite = {
              "" = " 🙈 No Windows? ";
            };
          };
          "memory" = {
            interval = 5;
            format = " {}%";
            tooltip = true;
          };
          "cpu" = {
            interval = 5;
            format = " {usage:2}%";
            tooltip = true;
          };
          "disk" = {
            format = " {free}";
            tooltip = true;
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
          };
          "custom/exit" = {
            tooltip = false;
            format = "";
            on-click = "sleep 0.1 && wlogout";
          };
          "custom/startmenu" = {
            tooltip = false;
            format = "";
            on-click = "sleep 0.1 && rofi-launcher";
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
          "custom/arrow1" = {
            format = "";
          };
          "custom/arrow2" = {
            format = "";
          };
          "custom/arrow3" = {
            format = "";
          };
          "custom/arrow4" = {
            format = "";
          };
          "custom/arrow5" = {
            format = "";
          };
          "custom/arrow6" = {
            format = "";
          };
          "custom/arrow7" = {
            format = "";
          };
        }
      ];
      style = concatStrings [
        ''
          * {
            font-family: JetBrainsMono Nerd Font, JetBrainsMono Nerd Font , JetBrainsMono Nerd Font;
            font-size: 14px;
            border-radius: 0px;
            border: none;
            min-height: 0px;
          }
          window#waybar {
            background: #${config.lib.stylix.colors.base00};
            color: #${config.lib.stylix.colors.base05};
          }
          #workspaces button {
            padding: 0px 5px;
            background: transparent;
            color: #${config.lib.stylix.colors.base04};
          }
          #workspaces button.active {
            color: #${config.lib.stylix.colors.base08};
          }
          #workspaces button:hover {
            color: #${config.lib.stylix.colors.base08};
          }
          tooltip {
            background: #${config.lib.stylix.colors.base00};
            border: 1px solid #${config.lib.stylix.colors.base05};
            border-radius: 12px;
          }
          tooltip label {
            color: #${config.lib.stylix.colors.base05};
          }
          #window {
            padding: 0px 10px;
          }
          #pulseaudio, #cpu, #memory, #idle_inhibitor {
            padding: 0px 10px;
            background: #${config.lib.stylix.colors.base04};
            color: #${config.lib.stylix.colors.base00};
          }
          #custom-startmenu {
            color: #${config.lib.stylix.colors.base02};
            padding: 0px 14px;
            font-size: 20px;
            background: #${config.lib.stylix.colors.base0B};
          }
          #custom-hyprbindings, #network, #battery,
          #custom-notification, #custom-exit {
            background: #${config.lib.stylix.colors.base0F};
            color: #${config.lib.stylix.colors.base00};
            padding: 0px 10px;
          }
          #tray {
            background: #${config.lib.stylix.colors.base02};
            color: #${config.lib.stylix.colors.base00};
            padding: 0px 10px;
          }
          #clock {
            font-weight: bold;
            padding: 0px 10px;
            color: #${config.lib.stylix.colors.base00};
            background: #${config.lib.stylix.colors.base0E};
          }
          #custom-arrow1 {
            font-size: 24px;
            color: #${config.lib.stylix.colors.base0E};
            background: #${config.lib.stylix.colors.base02};
          }
          #custom-arrow2 {
            font-size: 24px;
            color: #${config.lib.stylix.colors.base02};
            background: #${config.lib.stylix.colors.base0F};
          }
          #custom-arrow3 {
            font-size: 24px;
            color: #${config.lib.stylix.colors.base00};
            background: #${config.lib.stylix.colors.base0F};
          }
          #custom-arrow4 {
            font-size: 24px;
            color: #${config.lib.stylix.colors.base0F};
            background: transparent;
          }
          #custom-arrow6 {
            font-size: 24px;
            color: #${config.lib.stylix.colors.base0B};
            background: #${config.lib.stylix.colors.base04};
          }
          #custom-arrow7 {
            font-size: 24px;
            color: #${config.lib.stylix.colors.base04};
            background: transparent;
          }
        ''
      ];
    };
  }
