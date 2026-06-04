{ config, lib, ... }:
let
  stylixEnabled = config ? stylix && config.stylix.enable;
  palette = if stylixEnabled then config.stylix.base16Scheme else {
    base00 = "000000";
    base01 = "000000";
    base02 = "000000";
    base03 = "000000";
    base04 = "000000";
    base05 = "000000";
    base06 = "000000";
    base07 = "000000";
    base08 = "000000";
    base09 = "000000";
    base0A = "000000";
    base0B = "000000";
    base0C = "000000";
    base0D = "000000";
    base0E = "000000";
    base0F = "000000";
  };
in
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "sleep 1; systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        "label" = "reboot";
        "action" = "sleep 1; systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
      {
        "label" = "logout";
        "action" = "sleep 1; hyprctl dispatch exit";
        "text" = "Exit";
        "keybind" = "e";
      }
      {
        "label" = "suspend";
        "action" = "sleep 1; systemctl suspend";
        "text" = "Suspend";
        "keybind" = "u";
      }
      {
        "label" = "lock";
        "action" = "sleep 1; hyprlock";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "sleep 1; systemctl hibernate";
        "text" = "Hibernate";
        "keybind" = "h";
      }
    ];
    style = lib.mkIf stylixEnabled ''
      * {
        font-family: "JetBrainsMono NF", FontAwesome, sans-serif;
      	background-image: none;
      	transition: 20ms;
      }
      window {
      	background-color: rgba(12, 12, 12, 0.1);
      }
      button {
      	color: #${palette.base05};
        font-size:20px;
        background-repeat: no-repeat;
      	background-position: center;
      	background-size: 25%;
      	border-style: solid;
      	background-color: rgba(12, 12, 12, 0.3);
      	border: 3px solid #${palette.base05};
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        border-radius: 90px;
        margin: 20px;
      }
      button:focus,
      button:active,
      button:hover {
        color: #${palette.base00};
        background-color: #${palette.base0B};
        border: 3px solid #${palette.base0B};
      }
      #logout {
      	margin: 10px;
      	background-image: image(url("icons/logout.png"));
      }
      #suspend {
      	margin: 10px;
      	background-image: image(url("icons/suspend.png"));
      }
      #shutdown {
      	margin: 10px;
      	background-image: image(url("icons/shutdown.png"));
      }
      #reboot {
      	margin: 10px;
      	background-image: image(url("icons/reboot.png"));
      }
      #lock {
      	margin: 10px;
      	background-image: image(url("icons/lock.png"));
      }
      #hibernate {
      	margin: 10px;
      	background-image: image(url("icons/hibernate.png"));
      }
    '';
  };
}
