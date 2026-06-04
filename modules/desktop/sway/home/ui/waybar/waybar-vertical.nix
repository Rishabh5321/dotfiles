{ pkgs, lib, config, ... }:
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
in
with lib;
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd = {
      enable = true;
    };
    settings = {
      mainBar = {
        spacing = 0;
        layer = "top";
        position = "left";
        modules-left = [
          # "custom/os"
          # "gamemode"
          "sway/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "idle_inhibitor"
          "tray"
          "network"
          "bluetooth"
          "pulseaudio"
          "backlight"
          "battery"
          "custom/power"
        ];
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          spacing = 4;
          show-passive-items = true;
        };
        clock = {
          format = "{:%I\n%M\n%p}";
          interval = 60;
          tooltip = false;
        };
        "hyprland/window" = {
          icon = true;
          icon-size = 18;
        };
        "niri/window" = {
          format = "{}";
          max-length = 10;
          icon = true;
          icon-size = 14;
        };
        "hyprland/submap" = {
          format = "✌️ {}";
          max-length = 8;
          tooltip = false;
        };
        "hyprland/language" = {
          format = "{}";
        };
        "sway/workspaces" = {
          format = "<sub>{icon}</sub>{windows}";
          # format-window-separator = "\n";
          window-rewrite-default = "";
          window-rewrite = {
            "title<.*youtube.*>" = "";
            "class<firefox>" = "";
            "class<microsoft-edge>" = "󰇩";
            "class<code>" = "󰨞";
            "class<xwaylandvideobridge>" = "󰍹";
            "foot" = "";
            "class<imv>" = "";
            "zathura" = "";
            "nautilus" = "󰪶";
            "steam" = "";
            "dbeaver" = "";
            "mpv" = "";
            "libreoffice" = "󰏆";
            "微信" = "";
            "QQ" = "";
            "kdeconnect" = "";
          };
          show-special = true;
        };
        cpu = {
          format = "{usage}";
        };
        memory = {
          format = "{}";
        };
        disk = {
          interval = 30;
          format = "{percentage_used}";
          path = "/";
        };
        cava = {
          # cava_config = "$XDG_CONFIG_HOME/cava/cava.conf"; # 可选路径
          framerate = 30;
          autosens = 1;
          sensitivity = 100;
          bars = 14;
          lower_cutoff_freq = 50;
          higher_cutoff_freq = 10000;
          method = "pulse";
          source = "auto";
          stereo = true;
          reverse = false;
          bar_delimiter = 0;
          monstercat = false;
          waves = false;
          noise_reduction = 0.77;
          input_delay = 2;
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
          actions = {
            "on-click-right" = "mode";
          };
        };
        network = {
          on-click = "networkmanager_dmenu";
          on-click-right = "nm-connection-editor";
          format-wifi = "󰖩";
          format-ethernet = "";
          tooltip-format = "{ifname} via {gwaddr} \nIpaddr: {ipaddr} cidr: {cidr} cidr6: {cidr6}\nNetmask: {netmask} netmask6:{netmask6}\nEssid: {essid} ({signalStrength}%)\nTotal speed: {bandwidthTotalBytes}: {bandwidthUpBytes}/{bandwidthDownBytes} ";
          format-linked = "󰌷";
          format-disconnected = "⚠";
        };
        "network#speed" = {
          interval = 2;
          format-wifi = "󰡍";
          format-ethernet = "󰡍";
          tooltip-format = "";
          format-linked = "󰡍";
          format-disconnected = "⚠";
          format-alt = "Total: {bandwidthTotalBytes}: {bandwidthUpBytes}/{bandwidthDownBytes}";
        };
        backlight = {
          format = "{icon}";
          tooltip-format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        temperature = {
          thermal-zone = 5;
          critical-threshold = 80;
          format = "{temperatureC}";
          format-icons = [
            ""
            ""
            ""
          ];
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-full = "{icon}";
          format-charging = "";
          format-plugged = "";
          tooltip-format = "{timeTo}\nCapacity: {capacity}%\nPower draw: {power}w\nCycles: {cycles}\nHealth: {health}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        privacy = {
          icon-spacing = 0;
          icon-size = 14;
          transition-duration = 250;
          expand = true;
          modules = [
            {
              type = "screenshare";
              tooltip = true;
              tooltip-icon-size = 18;
            }
            {
              type = "audio-out";
              tooltip = true;
              tooltip-icon-size = 18;
            }
            {
              type = "audio-in";
              tooltip = true;
              tooltip-icon-size = 18;
            }
          ];
        };
        bluetooth = {
          on-click = "bzmenu -l rofi";
          on-click-right = "blueberry";
          format = "";
          format-disabled = "󰥊";
          format-off = "󰂲";
          format-on = "󰂯";
          format-connected = "󰂱";
          format-no-controller = "󰥊";
          format-connected-battery = "󰥉";
          # format-device-preference = [ "device1", "device2" ];  # preference list deciding the displayed device
          tooltip-format = "{controller_alias}\t{controller_address}\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n{num_connections} connected\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\tbat: {device_battery_percentage}%";
        };
        power-profiles-daemon = {
          format = "{icon}";
          "tooltip-format" = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          "format-icons" = {
            default = "";
            performance = "";
            balanced = "";
            "power-saver" = "";
          };
        };
        pulseaudio = {
          format = "{icon}\n{format_source}";
          tooltip-format = "Volume: {volume}%\n{desc}";
          "format-bluetooth" = "{icon}\n{format_source}";
          "format-bluetooth-muted" = "󰝟{icon}\n{format_source}";
          "format-muted" = "\n{format_source}";
          "format-source" = "󰍬";
          "format-source-muted" = "󰍭";
          "format-icons" = {
            headphone = "";
            "hands-free" = "󰋏";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };
        wireplumber = {
          format = "{icon}";
          format-muted = "";
          on-click = "helvum";
          format-icons = [
            ""
            ""
            ""
          ];
        };
        mpris = {
          format = "{player_icon}";
          format-paused = "{status_icon}";
          tooltip-format = "{player_icon} {dynamic}";
          tooltip-format-paused = "{status_icon} {dynamic}";
          player-icons = {
            default = "▶";
            mpv = "🎵";
          };
          status-icons = {
            paused = "⏸";
          };
        };
        gamemode = {
          format = "{glyph}";
          glyph = "󰺵";
          hide-not-running = true;
          use-icon = true;
          icon-name = "input-gaming-symbolic";
          icon-spacing = 0;
          icon-size = 14;
          tooltip = true;
          tooltip-format = "Games running: {count}";
        };
        "custom/power" = {
          format = "󰐥";
          tooltip = false;
          on-click = "wlogout";
        };
        "custom/os" = {
          format = "";
          on-click = "rofi -show drun";
          tooltip = false;
        };
        "custom/recorder" =
          let
            stop-screen-recorder = pkgs.writeShellScript "stop-screen-recorder" ''
              pid=`pgrep wl-screenrec`
              signal=$?

              if [ $signal == 0 ]; then
                pkill --signal SIGINT wl-screenrec
                dunstify "Stoped Screen recorder"
              fi;
            '';
          in
          {
            format = "";
            on-click = "${stop-screen-recorder}";
            return-type = "json";
            interval = 1;
            exec = "echo '{\"class\": \"recording\"}'";
            exec-if = "pgrep wl-screenrec";
          };
      };
    };
    style = concatStrings [
      ''
        * {
          font-family: JetBrainsMono Nerd Font;
          font-size: 16px;
          border-radius: 0px;
          border: none;
          min-height: 0px;
        }
        window#waybar {
          background: rgba(0,0,0,0);
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
      ''
    ];
  };
}
