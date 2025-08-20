{ pkgs
, config
, ...
}:
let
  swaync-client = "${pkgs.swaynotificationcenter}/bin/swaync-client";
  transition = "transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);";
  animateBlink = ''
    margin: 4px 0;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: steps(12);
    animation-iteration-count: infinite;
    animation-direction: alternate;
  '';
  moduleColor = side: n: color: ''
    .modules-${side} > widget:nth-child(${builtins.toString n}) > label {
      color: ${color};
    }
  '';
in
{
  config = with config.lib.stylix.colors; {
    stylix.targets.waybar.enable = false;
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
      };
      settings = {
        primary = {
          layer = "top";
          position = "left";
          # margin = "6";
          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            #"cpu"
            #"memory"
            #"disk"
            #"pulseaudio"
          ];
          modules-right = [
            "idle_inhibitor"
            "tray"
            "custom/notifications"
            # "network"
            "battery"
            "clock"
            # "custom/exit"
          ];
          "custom/exit" = {
            format = "  ";
            on-click = "loginctl terminate-user 1000";
            tooltip = false;
          };
          "custom/notifications" =
            let
              newDot = "<span color='#${base08}'><sup>  </sup></span>";
            in
            {
              tooltip = false;
              format = "{icon}<span color='#${base08}'>{}</span>";
              format-icons = {
                notification = "" + newDot;
                none = "";
                dnd-notification = "" + newDot;
                dnd-none = "";
                inhibited-notification = "" + newDot;
                inhibited-none = "";
                dnd-inhibited-notification = "" + newDot;
                dnd-inhibited-none = "";
              };
              return-type = "json";
              # ''\<char> is used to insert character verbatim in
              # indented strings, in this case `"`. Such as ''$
              # escapes $ in ${interpolations}
              exec = ''
                ${swaync-client} -swb | jq \
                  --unbuffered \
                  --compact-output \
                  'select(.text == ''\"0''\").text = ''\"''\"'
              '';
              on-click-release = "${swaync-client} -t -sw";
              on-click-right = "${swaync-client} -d -sw";
              escape = true;
            };
          "hyprland/workspaces".format = "{name}";
          clock = {
            format = "{:%H:%M}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              on-scroll = 1;
              on-click-right = "mode";
              format =
                let
                  formatEl = color: "<span color='#${color}'><b>{}</b></span>";
                in
                {
                  months = formatEl base0D;
                  days = formatEl base06;
                  weekdays = formatEl base07;
                  today = formatEl base08;
                };
            };
          };
          tray = {
            icon-size = 26;
            spacing = 8;
          };
          pulseaudio = {
            # or wireplumber - testing pa to see if formatting is better
            format = "vol\n{volume}%";
            format-muted = "vol\noff";
            on-click-release = "${pkgs.pavucontrol}/bin/pavucontrol";
          };
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };
          memory = {
            interval = 5;
            format = "ram\n{}%";
          };
          cpu = {
            interval = 5;
            format = "cpu\n{usage:2}%";
          };
          disk = {
            interval = 60;
            format = "hdd\n{percentage_used}%";
          };
          battery = {
            states = {
              warning = 25;
              critical = 15;
            };
            format-icons = [ "󱊡" "󱊢" "󱊣" ];
            format = "bat\n{capacity}%";
            format-charging = "chg\n{capacity}%";
          };
          network = {
            interval = 3;
            format-wifi = " ";
            format-ethernet = "󰈀";
            format-disconnected = "󱘖";
            tooltip-format = ''
              {ifname}: {essid}
              {ipaddr}/{cidr}
              Up: {bandwidthUpBits}
              Down: {bandwidthDownBits}
            '';
            on-click = "";
          };
        };
      };
      style = ''
        * {
          font-family: "JetBrainsMono Nerd Font Mono";
          font-size: 10pt;
          padding: 0;
          min-height: 0px;
          margin: 4px 0;
        }

        ${moduleColor "left" 1 "#${base08}"}
        ${moduleColor "left" 2 "#${base08}"}
        ${moduleColor "left" 3 "#${base09}"}
        ${moduleColor "left" 4 "#${base09}"}
        ${moduleColor "left" 5 "#${base0A}"}
        ${moduleColor "left" 6 "#${base0A}"}

        ${moduleColor "right" 1 "#${base0C}"}
        ${moduleColor "right" 2 "#${base0C}"}
        ${moduleColor "right" 3 "#${base0D}"}
        ${moduleColor "right" 4 "#${base0E}"}
        ${moduleColor "right" 5 "#${base0F}"}
        ${moduleColor "right" 6 "#${base0F}"}

        window#waybar {
          opacity: 0.90;
          background-color: #${base00};
        }

        #custom-exit {
          color: #D5FF80;
          text-shadow: 0 0 3px #D5FF80, 0 0 6px #148100;
        }

        #idle_inhibitor.activated {
          ${animateBlink}
        }

        #workspaces button {
          color: #${base05};
          border-radius: 0px;
          border-bottom: 0px;
          ${transition}
        }
        #workspaces button.focused,
        #workspaces button.active {
          border-left: 6px solid #${base0C};
          ${transition}
        }
        #battery.warning {
          background-color: #${base0A};
          color: #${base00};
        }
        @keyframes blink {
          to {
            background-color: #${base08};
            color: #${base00};
          }
        }
        #battery.critical:not(.charging) {
          color: #${base08};
          ${animateBlink}
        }
      '';
    };
  };
}
