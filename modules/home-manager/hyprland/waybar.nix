{
  pkgs,
  config,
  lib,
  ...
}: let
  palette = config.stylix.base16Scheme;
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit
    (import ./variables.nix)
    slickbar
    bar-number
    simplebar
    clock24h
    ;
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
          output = "eDP-1";
          modules-center = ["hyprland/workspaces"];
          modules-left = [
            "custom/startmenu"
            "hyprland/window"
            "network#speed"
          ];
          modules-right = [
            "backlight"
            "pulseaudio"
            "custom/exit"
            "idle_inhibitor"
            "custom/notification"
            "battery"
            "clock"
            "tray"
          ];

          "hyprland/workspaces" = {
            format =
              if bar-number
              then "{name}"
              else "{icon}";
            all-outputs = true;
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
              then '' {:%H:%M}''
              else '' {:%I:%M %p}'';
            #format = " {:%H:%M}";
            tooltip = true;
            tooltip-format = "<big>{:%A, %d.%B %Y }</big><tt><small>{calendar}</small></tt>";
          };
          "hyprland/window" = {
            min-length = 30;
            max-length = 30;
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
          "network#speed" = {
            interval = 1;
            format = "{ifname}";
            format-wifi = "{icon}   {bandwidthUpBits}   {bandwidthDownBits}";
            format-ethernet = "󰌘   {bandwidthUpBits}   {bandwidthDownBits}";
            format-disconnected = "󰌙";
            tooltip-format = "{ipaddr}";
            format-linked = "󰈁 {ifname} (No IP)";
            tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
            tooltip-format-ethernet = "{ifname} 󰌘";
            tooltip-format-disconnected = "󰌙 Disconnected";
            format-icons = [
              "󰤯"
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
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
          "custom/themeselector" = {
            tooltip = false;
            format = "";
            on-click = "sleep 0.1 && theme-selector";
          };
          "custom/exit" = {
            tooltip = false;
            format = "";
            on-click = "sleep 0.1 && wlogout";
          };
          "custom/startmenu" = {
            tooltip = false;
            format = "Menu";
            # exec = "rofi -show drun";
            on-click = "sleep 0.1 && rofi-launcher";
          };
          "custom/hyprbindings" = {
            tooltip = false;
            format = " Bindings";
            on-click = "sleep 0.1 && list-hypr-bindings";
          };
          backlight = {
            device = "intel_backlight";
            format = "{icon} {}%";
            format-icons = [
              ""
              ""
              ""
              "󰃝"
              "󰃞"
              "󰃟"
              "󰃠"
            ];
            on-scroll-up = "brightnessctl set 5%+";
            on-scroll-down = "brightnessctl set 5%-";
          };
          "idle_inhibitor" = {
            format = " {icon} ";
            format-icons = {
              activated = "";
              deactivated = "";
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
              warning = 25;
              critical = 10;
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
            tooltip = true;
          };
        }
      ];
      style = concatStrings [
        ''
               * {
          font-size: 16px;
          font-family: JetBrainsMono Nerd Font, JetBrainsMono Nerd Font , JetBrainsMono Nerd Font;
             	font-weight: bold;
               }
               window#waybar {
          ${
            if slickbar || simplebar
            then ''
              background-color: rgba(26,27,38,0);
              border-bottom: 1px solid rgba(26,27,38,0);
              border-radius: 0px;
              color: #${palette.base0F};
            ''
            else ''
              background-color: #${palette.base00};
              border-bottom: 1px solid #${palette.base00};
              border-radius: 0px;
              color: #${palette.base0F};
            ''
          }
               }
               #workspaces {
          ${
            if slickbar
            then ''
              background: #${palette.base00};
              margin: 5px;
              padding: 0px 1px;
              border-radius: 15px;
              border: 0px;
              font-style: normal;
              color: #${palette.base00};
            ''
            else if simplebar
            then ''
              color: #${palette.base00};
                     background: transparent;
              margin: 4px;
              border-radius: 0px;
              border: 0px;
              font-style: normal;
            ''
            else ''
              background: #${palette.base01};
              margin: 4px;
              padding: 0px 1px;
              border-radius: 10px;
              border: 0px;
              font-style: normal;
              color: #${palette.base00};
            ''
          }
               }
               #workspaces button {
          ${
            if slickbar
            then ''
              padding: 0px 5px;
              margin: 4px 3px;
              border-radius: 15px;
              border: 0px;
              color: #${palette.base00};
              background: linear-gradient(45deg, #${palette.base0C}, #${palette.base0D}, #${palette.base0E});
              opacity: 0.5;
              transition: ${betterTransition};
            ''
            else if simplebar
            then ''
              color: #${palette.base03};
                     background: #${palette.base00};
              margin: 4px 3px;
              opacity: 1;
              border: 0px;
              border-radius: 15px;
              transition: ${betterTransition};
            ''
            else ''
              padding: 0px 5px;
              margin: 4px 3px;
              border-radius: 10px;
              border: 0px;
              color: #${palette.base00};
                     background: linear-gradient(45deg, #${palette.base0E}, #${palette.base0F}, #${palette.base0D}, #${palette.base09});
                     background-size: 300% 300%;
                     animation: gradient_horizontal 15s ease infinite;
              opacity: 0.5;
                     transition: ${betterTransition};
            ''
          }
               }
               #workspaces button.active {
          ${
            if slickbar
            then ''
              padding: 0px 5px;
              margin: 4px 3px;
              border-radius: 15px;
              border: 0px;
              color: #${palette.base00};
              background: linear-gradient(45deg, #${palette.base0D}, #${palette.base0E});
              opacity: 1.0;
              min-width: 40px;
              transition: ${betterTransition};
            ''
            else if simplebar
            then ''
              color: #${palette.base00};
                     background: linear-gradient(118deg, #${palette.base0D} 5%, #${palette.base0F} 5%, #${palette.base0F} 20%, #${palette.base0D} 20%, #${palette.base0D} 40%, #${palette.base0F} 40%, #${palette.base0F} 60%, #${palette.base0D} 60%, #${palette.base0D} 80%, #${palette.base0F} 80%, #${palette.base0F} 95%, #${palette.base0D} 95%);
                     background-size: 300% 300%;
                     animation: swiping 15s linear infinite;
              border-radius: 15px;
              margin: 4px 3px;
              opacity: 1.0;
              border: 0px;
              min-width: 45px;
              transition: ${betterTransition};
            ''
            else ''
              padding: 0px 5px;
              margin: 4px 3px;
              border-radius: 10px;
              border: 0px;
              color: #${palette.base00};
                     background: linear-gradient(45deg, #${palette.base0E}, #${palette.base0F}, #${palette.base0D}, #${palette.base09});
                     background-size: 300% 300%;
                     animation: gradient_horizontal 15s ease infinite;
                     transition: ${betterTransition};
              opacity: 1.0;
              min-width: 40px;
            ''
          }
               }
               #workspaces button:hover {
          ${
            if slickbar
            then ''
              border-radius: 15px;
              color: #${palette.base00};
              background: linear-gradient(45deg, #${palette.base0D}, #${palette.base0E});
              opacity: 0.8;
              transition: ${betterTransition};
            ''
            else if simplebar
            then ''
              color: #${palette.base05};
              border: 0px;
              border-radius: 15px;
              transition: ${betterTransition};
            ''
            else ''
              border-radius: 10px;
              color: #${palette.base00};
                     background: linear-gradient(45deg, #${palette.base0E}, #${palette.base0F}, #${palette.base0D}, #${palette.base09});
                     background-size: 300% 300%;
                     animation: gradient_horizontal 15s ease infinite;
              opacity: 0.8;
                     transition: ${betterTransition};
            ''
          }
               }
               @keyframes gradient_horizontal {
          0% {
            background-position: 0% 50%;
          }
          50% {
            background-position: 100% 50%;
          }
          100% {
            background-position: 0% 50%;
          }
               }
               @keyframes swiping {
                 0% {
            background-position: 0% 200%;
          }
          100% {
            background-position: 200% 200%;
          }
               }
               tooltip {
          background: #${palette.base00};
          border: 1px solid #${palette.base0E};
          border-radius: 10px;
               }
               tooltip label {
          color: #${palette.base07};
               }
               #window {
          ${
            if slickbar
            then ''
              color: #${palette.base05};
              background: #${palette.base00};
              border-radius: 50px 15px 50px 15px;
              margin: 5px;
              padding: 2px 20px;
            ''
            else if simplebar
            then ''
              color: #${palette.base03};
              background: #${palette.base00};
              margin: 6px 4px;
              border-radius: 15px;
              padding: 0px 10px;
            ''
            else ''
              margin: 4px;
              padding: 2px 10px;
              color: #${palette.base05};
              background: #${palette.base01};
              border-radius: 10px;
            ''
          }
               }
               #memory {
            	color: #${palette.base0F};
          ${
            if slickbar
            then ''
              background: #${palette.base00};
              border-radius: 50px 15px 50px 15px;
              margin: 5px;
              padding: 2px 20px;
            ''
            else if simplebar
            then ''
              background: #${palette.base00};
              margin: 6px 4px;
              padding: 0px 10px;
              border-radius: 15px;
            ''
            else ''
              background: #${palette.base01};
              margin: 4px;
              padding: 2px 10px;
              border-radius: 10px;
            ''
          }
               }
               #clock, #backlight ,#pulseaudio {
             	color: #${palette.base0B};
          ${
            if slickbar
            then ''
              background: #${palette.base00};
              border-radius: 15px 50px 15px 50px;
              margin: 5px;
              padding: 2px 20px;
            ''
            else if simplebar
            then ''
              background: #${palette.base00};
              margin: 6px 4px;
              padding: 0px 10px;
              border-radius: 15px;
            ''
            else ''
              background: #${palette.base01};
              margin: 4px;
              padding: 2px 10px;
              border-radius: 10px;
            ''
          }
               }
               #cpu {
             	color: #${palette.base07};
          ${
            if slickbar
            then ''
              background: #${palette.base00};
              border-radius: 50px 15px 50px 15px;
              margin: 5px;
              padding: 2px 20px;
            ''
            else if simplebar
            then ''
              background: #${palette.base00};
              margin: 6px 4px;
              padding: 0px 10px;
              border-radius: 15px;
            ''
            else ''
              background: #${palette.base01};
              margin: 4px;
              padding: 2px 10px;
              border-radius: 10px;
            ''
          }
               }
               #disk {
             	color: #${palette.base03};
          ${
            if slickbar
            then ''
              background: #${palette.base00};
              border-radius: 15px 50px 15px 50px;
              margin: 5px;
              padding: 2px 20px;
            ''
            else if simplebar
            then ''
              background: #${palette.base00};
              margin: 6px 4px;
              padding: 0px 10px;
              border-radius: 15px;
            ''
            else ''
              background: #${palette.base01};
              margin: 4px;
              padding: 2px 10px;
              border-radius: 10px;
            ''
          }
               }
               #battery {
             	color: #${palette.base08};
          ${
            if slickbar
            then ''
              background: #${palette.base00};
              border-radius: 15px 50px 15px 50px;
              margin: 5px;
              padding: 2px 20px;
            ''
            else if simplebar
            then ''
              background: #${palette.base00};
              margin: 6px 4px;
              padding: 0px 10px;
              border-radius: 15px;
            ''
            else ''
              background: #${palette.base01};
              margin: 4px;
              padding: 2px 10px;
              border-radius: 10px;
            ''
          }
               }
               #battery.critical {
                 color: #${palette.base07};
          ${
            if slickbar
            then ''
              background: #${palette.base08};
              border-radius: 15px 50px 15px 50px;
              margin: 5px;
              padding: 2px 20px;
            ''
            else if simplebar
            then ''
              background: #${palette.base08};
              margin: 6px 4px;
              padding: 0px 10px;
              border-radius: 15px;
            ''
            else ''
              background: #${palette.base08};
              margin: 4px;
              padding: 2px 10px;
              border-radius: 10px;
            ''
          }
               }
               #battery.warning {
                 color: #${palette.base07};
          ${
            if slickbar
            then ''
              background: #${palette.base0F};
              border-radius: 15px 50px 15px 50px;
              margin: 5px;
              padding: 2px 20px;
            ''
            else if simplebar
            then ''
              background: #${palette.base0F};
              margin: 6px 4px;
              padding: 0px 10px;
              border-radius: 15px;
            ''
            else ''
              background: #${palette.base0F};
              margin: 4px;
              padding: 2px 10px;
              border-radius: 10px;
            ''
          }
               }

               #network, #network#speed {
             	color: #${palette.base09};
          ${
            if slickbar
            then ''
              background: #${palette.base00};
              border-radius: 50px 15px 50px 15px;
              margin: 5px;
              padding: 2px 20px;
            ''
            else if simplebar
            then ''
              background: #${palette.base00};
              margin: 6px 4px;
              padding: 0px 10px;
              border-radius: 15px;
            ''
            else ''
              background: #${palette.base01};
              margin: 4px;
              padding: 2px 10px;
              border-radius: 10px;
            ''
          }
               }
               #custom-hyprbindings {
             	color: #${palette.base0E};
          ${
            if slickbar
            then ''
              background: #${palette.base00};
              border-radius: 15px 50px 15px 50px;
              margin: 5px;
              padding: 2px 20px;
            ''
            else if simplebar
            then ''
              background: #${palette.base00};
              margin: 6px 4px;
              padding: 0px 10px;
              border-radius: 15px;
            ''
            else ''
              background: #${palette.base01};
              margin: 4px;
              padding: 2px 10px;
              border-radius: 10px;
            ''
          }
               }
               #tray {
             	color: #${palette.base05};
          ${
            if slickbar
            then ''
              background: #${palette.base00};
              border-radius: 15px 0px 0px 50px;
              margin: 5px 0px 5px 5px;
              padding: 2px 20px;
            ''
            else if simplebar
            then ''
              background: #${palette.base00};
              margin: 6px 4px;
              padding: 0px 10px;
              border-radius: 15px;
            ''
            else ''
              background: #${palette.base01};
              margin: 4px;
              padding: 2px 10px;
              border-radius: 10px;
            ''
          }
               }
               #pulseaudio1 {
             	color: #${palette.base0D};
          ${
            if slickbar
            then ''
              background: #${palette.base00};
              border-radius: 50px 15px 50px 15px;
              margin: 5px;
              padding: 2px 20px;
            ''
            else if simplebar
            then ''
              background: #${palette.base00};
              margin: 6px 4px;
              padding: 0px 10px;
              border-radius: 15px;
            ''
            else ''
              background: #${palette.base01};
              margin: 4px;
              padding: 2px 10px;
              border-radius: 10px;
            ''
          }
               }
               #custom-notification {
             	color: #${palette.base0C};
          ${
            if slickbar
            then ''
              background: #${palette.base00};
              border-radius: 15px 50px 15px 50px;
              margin: 5px;
              padding: 2px 20px;
            ''
            else if simplebar
            then ''
              background: #${palette.base00};
              margin: 6px 4px;
              padding: 0px 10px;
              border-radius: 15px;
            ''
            else ''
              background: #${palette.base01};
              margin: 4px;
              padding: 2px 10px;
              border-radius: 10px;
            ''
          }
               }
               #custom-themeselector,  #idle_inhibitor {
             	color: #${palette.base0D};
          ${
            if slickbar
            then ''
              background: #${palette.base00};
              border-radius: 0px 50px 15px 0px;
              margin: 5px 0px;
              padding: 2px 15px 2px 5px;
            ''
            else if simplebar
            then ''
              background: #${palette.base00};
              margin: 6px 4px 6px 0px;
              padding: 0px 10px 0px 5px;
              border-radius: 0px 15px 15px 0px;
            ''
            else ''
              background: #${palette.base01};
              margin: 4px 0px;
              padding: 2px 10px 2px 5px;
              border-radius: 0px 10px 10px 0px;
            ''
          }
               }
               #custom-startmenu {
             	color: #${palette.base03};
          ${
            if slickbar
            then ''
              background: #${palette.base00};
              border-radius: 0px 15px 50px 0px;
              margin: 5px 5px 5px 0px;
              padding: 2px 20px;
            ''
            else if simplebar
            then ''
              background: #${palette.base00};
              margin: 6px 4px;
              padding: 0px 8px 0px 10px;
              border-radius: 15px;
            ''
            else ''
              background: #${palette.base01};
              margin: 4px;
              padding: 2px 10px;
              border-radius: 10px;
            ''
          }
               }
               #custom-exit {
             	color: #${palette.base0E};
          ${
            if slickbar
            then ''
              background: #${palette.base00};
              border-radius: 15px 0px 0px 50px;
              margin: 5px 0px;
              padding: 2px 5px 2px 15px;
            ''
            else if simplebar
            then ''
              background: #${palette.base00};
              margin: 6px 0px 6px 4px;
              padding: 0px 5px 0px 10px;
              border-radius: 15px 0px 0px 15px;
            ''
            else ''
              background: #${palette.base01};
              margin: 4px 0px;
              padding: 2px 5px 2px 10px;
              border-radius: 10px 0px 0px 10px;
            ''
          }
               } ''
      ];
    };
  }
