_: {
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
        label = "reboot";
        action = "sleep 1; systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "logout";
        action = "sleep 1; swaymsg exit";
        text = "Exit";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "sleep 1; systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "lock";
        action = "sleep 1; swaylock -f";
        text = "Lock";
        keybind = "l";
      }
    ];
    style = ''
      * {
        font-family: "JetBrainsMono NF", sans-serif;
        transition: 20ms;
      }
      window {
        background-color: rgba(12, 12, 12, 0.1);
      }
      button {
        color: #cdd6f4;
        font-size: 20px;
        background-color: rgba(12, 12, 12, 0.3);
        border: 3px solid #cdd6f4;
        border-radius: 90px;
        margin: 20px;
      }
      button:hover {
        color: #1e1e2e;
        background-color: #a6e3a1;
        border: 3px solid #a6e3a1;
      }
    '';
  };
}
