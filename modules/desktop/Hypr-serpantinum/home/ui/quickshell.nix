{ inputs
, pkgs
, config
, ...
}:
{
  imports = [
    inputs.serpantinum.homeManagerModules.default
  ];

  programs.serpantinum = {
    enable = true;
    systemd.enable = true;
    package = inputs.serpantinum.packages.${pkgs.stdenv.hostPlatform.system}.default;

    settings = {
      # Core Theme & Appearance
      wallpaperDir = "${config.home.homeDirectory}/Pictures/Wallpapers";

      general = {
        language = "en";
        weatherUnit = "metric";
        weatherInterval = 30;
        workspaceCount = 10;
        muteSfx = false;
      };

      theme = {
        fontFamily = "Adwaita Mono";
        borderRadius = 12;
        activePreset = "Matugen";
        matugen = true;
      };

      # Bar Configuration (mirrors the DMS bar layout)
      bar = {
        position = "top";
        style = "solid";
        width = 40;
        opacity = 100;
        autohide = false;
        workspaceCount = 10;
        modules = {
          left = [
            "workspaces"
            "media"
          ];
          center = [
            [
              "timedate"
              "weather"
            ]
          ];
          right = [
            "tray"
            [
              "kb"
              "wifi"
              "bt"
              "vol"
              "bat"
            ]
          ];
        };
        time = {
          format = "hh:mm A";
        };
      };

      # Dock / Desktop widgets (DMS: showDock/systemMonitor/desktopClock disabled)
      dock = {
        enabled = false;
      };

      widgets = {
        systemMonitor = false;
        desktopClock = false;
      };

      # Notifications
      notifications = {
        dnd = false;
        position = "top right";
        sound = true;
      };

      # Power & Idle Management (mirrors DMS timeouts)
      idle = {
        enabled = true;
        actions = {
          dim = {
            enabled = true;
            timeout = 120;
          };
          lock = {
            enabled = true;
            timeout = 60;
          };
          dpms = {
            enabled = true;
            timeout = 120;
          };
          suspend = {
            enabled = false;
            timeout = 600;
          };
        };
      };
    };
  };

}
