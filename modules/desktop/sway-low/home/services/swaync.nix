_: {
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      notification-icon-size = 48;
      timeout = 5;
      timeout-low = 3;
      timeout-critical = 0;
      control-center-width = 350;
      notification-window-width = 350;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = true;
      hide-on-action = true;
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        volume = {
          label = "󰕾";
        };
        backlight = {
          label = "󰃟";
        };
      };
      widgets = [
        "title"
        "volume"
        "backlight"
        "dnd"
        "notifications"
      ];
    };
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font Mono", monospace;
      }
      .control-center {
        background: #1e1e2e;
        border: 2px solid #313244;
        border-radius: 8px;
      }
      .notification-content {
        background: #181825;
        padding: 8px;
        border-radius: 6px;
        border: 1px solid #313244;
      }
      .summary {
        font-weight: bold;
        color: #cdd6f4;
      }
      .time {
        color: #6c7086;
        margin-right: 8px;
      }
      .body {
        color: #bac2de;
      }
      .close-button {
        background: #f38ba8;
        color: #1e1e2e;
        border-radius: 50%;
        padding: 2px;
      }
      .widget-title {
        color: #a6e3a1;
        padding: 8px;
        margin: 8px;
        font-size: 1.2rem;
        border-radius: 6px;
      }
      .widget-volume {
        background: #313244;
        padding: 5px;
        margin: 8px;
        border-radius: 6px;
      }
      .widget-backlight {
        background: #313244;
        padding: 5px;
        margin: 8px;
        border-radius: 6px;
      }
    '';
  };
}
