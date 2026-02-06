{ inputs
, username
, wallpaper
, lib
, ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    settings = {
      appLauncher = {
        # backgroundOpacity = 1;
        customLaunchPrefix = "";
        customLaunchPrefixEnabled = false;
        enableClipboardHistory = true;
        enableClipPreview = false;
        pinnedExecs = [ ];
        position = "center";
        sortByMostUsed = true;
        terminalCommand = "kitty -e";
        useApp2Unit = false;
      };

      audio = {
        volumeStep = 5;
        volumeOverdrive = false;
        cavaFrameRate = 30;
        visualizerType = "linear";
        visualizerQuality = "high";
        mprisBlacklist = [ ];
        preferredPlayer = "";
        externalMixer = "pwvucontrol || pavucontrol";
      };

      bar = {
        position = "top";
        backgroundOpacity = lib.mkForce "0.0";
        useSeparateOpacity = true;
        monitors = [ ];
        density = "default";
        showCapsule = true;
        # capsuleOpacity = 1;
        floating = false;
        marginVertical = 0.25;
        marginHorizontal = 0.25;
        outerCorners = true;
        exclusive = true;
        widgets = {
          center = [
            {
              characterCount = 2;
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "name";
            }
          ];

          left = [
            {
              id = "SystemMonitor";
              showCpuTemp = true;
              showCpuUsage = true;
              showDiskUsage = false;
              showMemoryAsPercent = false;
              showMemoryUsage = true;
              showNetworkStats = true;
              compactMode = false;
            }
            {
              colorizeIcons = false;
              hideMode = "hidden";
              id = "ActiveWindow";
              maxWidth = 145;
              scrollingMode = "hover";
              showIcon = true;
              useFixedWidth = false;
            }
            {
              hideMode = "hidden";
              id = "MediaMini";
              maxWidth = 145;
              scrollingMode = "hover";
              showAlbumArt = false;
              showVisualizer = false;
              useFixedWidth = false;
              visualizerType = "linear";
            }
          ];

          right = [
            { id = "ScreenRecorder"; }
            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "KeepAwake";
            }
            {
              hideWhenZero = true;
              id = "NotificationHistory";
              showUnreadBadge = true;
            }
            {
              displayMode = "onhover";
              id = "Battery";
              warningThreshold = 30;
            }
            {
              displayMode = "onhover";
              id = "Volume";
            }
            {
              displayMode = "onhover";
              id = "Brightness";
            }
            {
              blacklist = [ ];
              colorizeIcons = false;
              id = "Tray";
            }
            {
              customFont = "";
              formatHorizontal = "h:mm AP ddd, MMM dd";
              formatVertical = "h mm AP - dd MM";
              id = "Clock";
              useCustomFont = false;
              usePrimaryColor = true;
            }
            {
              customIconPath = "";
              icon = "noctalia";
              id = "ControlCenter";
              useDistroLogo = false;
            }
          ];
        };
      };

      battery = {
        chargingMode = 0;
      };

      brightness = {
        brightnessStep = 5;
        enforceMinimum = true;
      };

      colorSchemes = {
        useWallpaperColors = true;
        predefinedScheme = "Noctalia (default)";
        darkMode = true;
        schedulingMode = "off";
        manualSunrise = "06:30";
        manualSunset = "18:30";
        matugenSchemeType = "scheme-content";
        generateTemplatesForPredefined = true;
      };

      controlCenter = {
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];

        # position = "close_to_bar_button";

        shortcuts = {
          left = [
            { id = "WiFi"; }
            { id = "Bluetooth"; }
            { id = "ScreenRecorder"; }
            { id = "WallpaperSelector"; }
          ];

          right = [
            { id = "Notifications"; }
            { id = "PowerProfile"; }
            { id = "KeepAwake"; }
            { id = "NightLight"; }
          ];
        };
      };

      dock = {
        # backgroundOpacity = 1;
        colorizeIcons = false;
        displayMode = "always_visible";
        enabled = false;
        floatingRatio = 1;
        monitors = [ ];
        onlySameOutput = true;
        pinnedApps = [ ];
        size = 1;
      };

      systemMonitor = {
        cpuWarningThreshold = 80;
        cpuCriticalThreshold = 90;
        tempWarningThreshold = 80;
        tempCriticalThreshold = 90;
        memWarningThreshold = 80;
        memCriticalThreshold = 90;
        diskWarningThreshold = 80;
        diskCriticalThreshold = 90;
        useCustomColors = false;
      };

      general = {
        avatarImage = "";
        dimmerOpacity = 0.6;
        showScreenCorners = false;
        forceBlackScreenCorners = false;
        scaleRatio = 1;
        radiusRatio = 1;
        screenRadiusRatio = 1;
        animationSpeed = 1;
        animationDisabled = false;
        compactLockScreen = false;
        lockOnSuspend = true;
        showHibernateOnLockScreen = false;
        enableShadows = true;
        shadowDirection = "bottom_right";
        shadowOffsetX = 2;
        shadowOffsetY = 3;
        language = "";
        allowPanelsOnScreenWithoutBar = true;
      };

      calendar = {
        cards = [
          {
            id = "banner-card";
            enabled = true;
          }
          {
            id = "calendar-card";
            enabled = true;
          }
          {
            id = "timer-card";
            enabled = true;
          }
          {
            id = "weather-card";
            enabled = true;
          }
        ];
      };

      hooks = {
        darkModeChange = "";
        enabled = false;
        wallpaperChange = "";
      };

      location = {
        name = "Nashik, India";
        weatherEnabled = true;
        weatherShowEffects = true;
        useFahrenheit = false;
        use12hourFormat = false;
        showWeekNumberInCalendar = false;
        showCalendarEvents = true;
        showCalendarWeather = true;
        analogClockInCalendar = false;
        firstDayOfWeek = -1;
      };

      network = {
        wifiEnabled = true;
      };

      nightLight = {
        autoSchedule = true;
        dayTemp = "6500";
        enabled = false;
        forced = false;
        manualSunrise = "06:30";
        manualSunset = "18:30";
        nightTemp = "4000";
      };

      notifications = {
        enabled = true;
        monitors = [ ];
        location = "top_right";
        overlayLayer = true;
        # backgroundOpacity = 1;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
        enableKeyboardLayoutToast = true;
      };

      osd = {
        enabled = true;
        location = "top_right";
        autoHideMs = 2000;
        overlayLayer = true;
        # backgroundOpacity = 1;
        enabledTypes = [ ];
        monitors = [ ];
      };

      screenRecorder = {
        directory = "/home/${username}/Videos";
        frameRate = 60;
        audioCodec = "opus";
        videoCodec = "h264";
        quality = "very_high";
        colorRange = "limited";
        showCursor = true;
        audioSource = "default_output";
        videoSource = "portal";
      };

      settingsVersion = 16;
      setupCompleted = true;

      templates = {
        alacritty = false;
        code = false;
        discord = false;
        discord_armcord = false;
        discord_dorion = false;
        discord_equibop = false;
        discord_lightcord = false;
        discord_vesktop = false;
        discord_webcord = false;
        enableUserTemplates = false;
        foot = false;
        fuzzel = false;
        ghostty = false;
        gtk = false;
        kcolorscheme = false;
        kitty = false;
        pywalfox = false;
        qt = false;
        vicinae = false;
        walker = false;
      };

      ui = {
        # fontDefault = "Roboto";
        # fontFixed = "DejaVu Sans Mono";
        fontDefaultScale = 1;
        fontFixedScale = 1;
        tooltipsEnabled = true;
        # panelBackgroundOpacity = 1;
        panelsAttachedToBar = true;
        settingsPanelAttachToBar = false;
      };

      wallpaper = {
        defaultWallpaper = "/home/${username}/Pictures/Wallpapers/${wallpaper}";
        enableMultiMonitorDirectories = false;
        enabled = true;
        fillColor = "#000000";
        fillMode = "crop";
        randomEnabled = false;
        randomIntervalSec = 1800;
        recursiveSearch = true;
        setWallpaperOnAllMonitors = true;
        transitionDuration = 1500;
        transitionEdgeSmoothness = 0.05;
        transitionType = "random";
      };
    };
  };
}
