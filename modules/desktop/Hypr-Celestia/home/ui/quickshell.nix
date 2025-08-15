{ config
, inputs
, pkgs
, lib
, ...
}:
let
  isLaptop = true;
  shellPkg = inputs.caelestia-shell.packages.${pkgs.system}.default;
  quickshellPkg = inputs.quickshell.packages.${pkgs.system}.default.override {
    withX11 = false;
    withI3 = false;
  };
  cliPkg = inputs.caelestia-cli.packages.${pkgs.system}.default;
  logging = lib.concatStringsSep ";" [
    "quickshell.dbus.properties.warning=false"
    "quickshell.dbus.dbusmenu.warning=false"
    "quickshell.service.notifications.warning=false"
    "quickshell.service.sni.host.warning=false"
    "qt.qpa.wayland.textinput.warning=false"
  ];
in
{
  home.packages = [
    shellPkg
    quickshellPkg
    cliPkg
  ];

  home.file.".config/caelestia/shell.json".text = builtins.toJSON {
    appearance = {
      anim.durations.scale = 1;
      font = {
        family = {
          material = "Material Symbols Rounded";
          mono = "MesloLGLDZ Nerd Font Mono";
          sans = "Inter";
          clock = "Inter";
        };
        size.scale = 1;
      };
      padding.scale = 1;
      rounding.scale = 1;
      spacing.scale = 1;
      transparency = {
        enabled = false;
        base = 1;
        layers = 1;
      };
    };
    general = {
      apps = {
        terminal = [ "kitty" ];
        audio = [ "pwvucontrol" ];
      };
    };
    background = {
      enabled = false;
      desktopClock = true;
    };
    bar = {
      entries = [
        {
          id = "logo";
          enabled = false;
        }
        {
          id = "workspaces";
          enabled = true;
        }
        {
          id = "spacer";
          enabled = true;
        }
        {
          id = "activeWindow";
          enabled = true;
        }
        {
          id = "spacer";
          enabled = true;
        }
        {
          id = "tray";
          enabled = true;
        }
        {
          id = "clock";
          enabled = true;
        }
        {
          id = "statusIcons";
          enabled = true;
        }
        {
          id = "power";
          enabled = true;
        }
      ];
      dragThreshold = 20;
      persistent = true;
      showOnHover = true;
      workspaces = {
        activeIndicator = true;
        activeLabel = "󰮯 ";
        activeTrail = true;
        label = "  ";
        occupiedBg = false;
        occupiedLabel = "󰮯 ";
        perMonitorWorkspaces = true;
        rounded = true;
        showWindows = true;
        shown = 5;
      };
      status = {
        showAudio = true;
        showBattery = isLaptop;
        showBluetooth = true;
        showNetwork = isLaptop;
        showKbLayout = false;
      };
      tray = {
        background = true;
        recolour = true;
      };
    };
    border = {
      rounding = 10;
      thickness = 10;
    };
    dashboard = {
      mediaUpdateInterval = 500;
      visualiserBars = 45;
    };
    launcher = {
      actionPrefix = "!";
      dragThreshold = 50;
      vimKeybinds = true;
      enableDangerousActions = false;
      maxShown =
        if isLaptop
        then 6
        else 10;
      maxWallpapers = 9;
      useFuzzy = {
        apps = true;
        actions = false;
        schemes = true;
        variants = true;
        wallpapers = true;
      };
    };
    lock = {
      recolourLogo = true;
      maxNotifs =
        if isLaptop
        then 5
        else 8;
    };
    notifs = {
      actionOnClick = true;
      clearThreshold = 0.3;
      defaultExpireTimeout = 5000;
      expandThreshold = 20;
      expire = false;
    };
    osd = {
      hideDelay = 2000;
    };
    paths = {
      mediaGif = "root:/assets/bongocat.gif";
      sessionGif = "root:/assets/kurukuru.gif";
      wallpaperDir = config.home.homeDirectory + "/Pictures/WallpapersCache";
    };
    services = {
      weatherLocation = "19.9973, 73.791";
      useFahrenheit = false;
      useTwelveHourClock = true;
      audioIncrement = 0.05;
      smartScheme = true;
    };
    session = {
      dragThreshold = 30;
      vimKeybinds = true;
      commands = {
        logout = [ "loginctl" "terminate-user" "" ];
        shutdown = [ "systemctl" "poweroff" ];
        hibernate = [ "systemctl" "suspend" ];
        reboot = [ "systemctl" "reboot" ];
      };
    };
  };
  # Services
  systemd = {
    user = {
      services = {
        caelestia-shell = {
          Unit = {
            Description = "Caelestia desktop shell";
            After = [ "graphical-session.target" ];
          };
          Install.WantedBy = [ "graphical-session.target" ];
          Service = {
            ExecStart = lib.getExe shellPkg;
            Environment = "QT_LOGGING_RULES=${logging}";
            Restart = "on-failure";
          };
        };

        #   caelestia-colors = {
        #     Unit.Description = "Generate Hyprland colors from caelestia scheme";
        #     Service = {
        #       Type = "oneshot";
        #       ExecStart = lib.getExe colorSyncPkg;
        #     };
        #   };
        # };
        #
        # paths.caelestia-colors = {
        #   Unit.Description = "Watch caelestia scheme for changes";
        #   Path = {
        #     PathModified = config.home.homeDirectory + "/.local/state/caelestia/scheme.json";
        #     Unit = "caelestia-colors.service";
        #   };
        #   Install.WantedBy = ["graphical-session.target"];
      };
    };
  };
  # systemd.user.services.caelestia-lock-once = {
  #   Unit = {
  #     Description = "Lock screen once after Caelestia shell is ready";
  #     After = ["graphical-session.target" "caelestia-shell.service"];
  #     Wants = ["caelestia-shell.service"];
  #   };
  #   Service = {
  #     Type = "oneshot";
  #     # tiny retry loop to avoid races without ugly sleeps
  #     ExecStart = let
  #       script =
  #         pkgs.writeShellScript "caelestia-lock-once"
  #         ''
  #           set -euo pipefail
  #           for i in $(seq 1 150); do
  #             if ${lib.getExe cliPkg} shell lock lock >/dev/null 2>&1; then
  #               exit 0
  #             fi
  #             sleep 0.1
  #           done
  #           echo "caelestia lock: shell not ready after 15s, giving up" >&2
  #           exit 1
  #         '';
  #     in
  #       script;
  #     # Optional: cleaner logs
  #     Environment = "PATH=${lib.makeBinPath [pkgs.coreutils cliPkg]}";
  #   };
  #   Install.WantedBy = ["graphical-session.target"];
  # };
}
