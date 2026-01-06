{ inputs
, config
, lib
, ...
}:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
    settings = {
      # Theme & Core Appearance
      currentThemeName = "dynamic";
      currentThemeCategory = "dynamic";
      matugenScheme = "scheme-content"; # Updated
      runUserMatugenTemplates = true;
      widgetBackgroundColor = "sch";
      widgetColorMode = "colorful";
      cornerRadius = 12;
      popupTransparency = 1;
      dockTransparency = 1;

      # Fonts & Icons
      fontFamily = "Inter Variable";
      monoFontFamily = "Fira Code";
      iconTheme = "System Default";
      launcherLogoMode = "os";

      # Workspace Settings
      showWorkspaceIndex = true; # Updated
      showWorkspaceName = false;
      showWorkspacePadding = false;
      maxWorkspaceIcons = 3;
      groupWorkspaceApps = true;
      workspacesPerMonitor = true;

      # Global Widget Visibility
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
          spacing = 0; # Updated
          innerPadding = 4;
          transparency = 0;
          widgetTransparency = 1;
          shadowOpacity = 56; # Updated
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

      # Control Center
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

      # Systemd/Matugen Template Toggles
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

      # Power Management & Time
      use24HourClock = false;
      powerActionConfirm = true;
      powerMenuActions = [ "reboot" "logout" "poweroff" "lock" "suspend" "restart" ];
      powerMenuDefaultAction = "logout";

      # Disabled Modules
      systemMonitorEnabled = false;
      desktopClockEnabled = false;

      configVersion = 5;
    };
  };

  # Environment fix for DMS services
  systemd.user.services.dms = {
    Service = {
      Environment = lib.mkForce "PATH=/run/current-system/sw/bin:/etc/profiles/per-user/${config.home.username}/bin:${config.home.profileDirectory}/bin:$PATH";
    };
  };
}
