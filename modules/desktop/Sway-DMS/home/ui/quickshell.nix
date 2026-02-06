{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    settings = {
      # Core Theme & Appearance
      # currentThemeName = "dynamic";
      currentThemeCategory = "dynamic";
      matugenScheme = "scheme-content";
      runUserMatugenTemplates = true;
      widgetBackgroundColor = "sch";
      widgetColorMode = "colorful";
      cornerRadius = 12;
      popupTransparency = 1;
      dockTransparency = 1;

      # Cursor Settings (New)
      cursorSettings = {
        theme = "System Default";
        size = 24;
        niri = {
          hideWhenTyping = false;
          hideAfterInactiveMs = 0;
        };
        hyprland = {
          hideOnKeyPress = false;
          hideOnTouch = false;
          inactiveTimeout = 0;
        };
        dwl = {
          cursorHideTimeout = 0;
        };
      };

      # Layout & WM Visibility
      showWorkspaceIndex = true;
      showWorkspaceName = false;
      showLauncherButton = true;
      showWorkspaceSwitcher = true;
      showFocusedWindow = true;
      showWeather = true;
      useAutoLocation = true;
      showMusic = true;
      showClipboard = true;
      showCpuUsage = true;
      showMemUsage = true;
      showCpuTemp = true;
      showGpuTemp = true;
      showSystemTray = true;
      showClock = true;
      showNotificationButton = true;
      showBattery = true;
      showControlCenterButton = true;
      showCapsLockIndicator = true;

      # Bar Configuration
      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = [ "all" ];
          showOnLastDisplay = true;
          spacing = 0;
          innerPadding = 4;
          transparency = 0;
          widgetTransparency = 1;
          shadowOpacity = 56;
          leftWidgets = [
            { enabled = true; id = "launcherButton"; }
            "workspaceSwitcher"
            "focusedWindow"
          ];
          centerWidgets = [ "music" "clock" "weather" ];
          rightWidgets = [
            { enabled = true; id = "idleInhibitor"; }
            { enabled = true; id = "network_speed_monitor"; }
            { enabled = true; id = "systemTray"; }
            { enabled = true; id = "cpuUsage"; }
            { enabled = true; id = "memUsage"; }
            { enabled = true; id = "notificationButton"; }
            { enabled = true; id = "battery"; }
            { enabled = true; id = "controlCenterButton"; }
          ];
        }
      ];

      # Control Center Widgets
      controlCenterWidgets = [
        { enabled = true; id = "volumeSlider"; width = 50; }
        { enabled = true; id = "brightnessSlider"; width = 50; }
        { enabled = true; id = "wifi"; width = 50; }
        { enabled = true; id = "bluetooth"; width = 50; }
        { enabled = true; id = "audioOutput"; width = 50; }
        { enabled = true; id = "audioInput"; width = 50; }
        { enabled = true; id = "nightMode"; width = 50; }
        { enabled = true; id = "darkMode"; width = 50; }
      ];

      # Matugen Template Configuration
      runDmsMatugenTemplates = true;
      matugenTemplateGtk = true;
      matugenTemplateNiri = true;
      matugenTemplateHyprland = true;
      matugenTemplateMangowc = true;
      matugenTemplateQt5ct = true;
      matugenTemplateQt6ct = true;
      matugenTemplateFirefox = true;
      matugenTemplatePywalfox = true;
      matugenTemplateZenBrowser = true;
      matugenTemplateVesktop = true;
      matugenTemplateEquibop = true;
      matugenTemplateGhostty = true;
      matugenTemplateKitty = true;
      matugenTemplateFoot = true;
      matugenTemplateAlacritty = true;
      matugenTemplateNeovim = true;
      matugenTemplateWezterm = true;
      matugenTemplateDgop = true;
      matugenTemplateKcolorscheme = true;
      matugenTemplateVscode = true;

      # Power & Locale
      use24HourClock = false; # Updated from JSON
      batteryMonitorTimeout = 600; # Updated from JSON
      batteryLockTimeout = 300;
      batterySuspendTimeout = 600;
      powerActionConfirm = true;
      powerMenuActions = [ "reboot" "logout" "poweroff" "lock" "suspend" "restart" ];

      # Feature Toggles
      systemMonitorEnabled = false;
      desktopClockEnabled = false;
      showDock = false;

      configVersion = 5;
    };
  };

  # Environment fix for DMS executable paths
  systemd.user.services.dms = {
    Service = {
      Environment = lib.mkForce "PATH=/run/current-system/sw/bin:/etc/profiles/per-user/${config.home.username}/bin:${config.home.profileDirectory}/bin:$PATH";
    };
  };
}
