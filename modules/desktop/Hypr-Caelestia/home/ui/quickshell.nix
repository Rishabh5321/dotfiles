{ self, lib, pkgs, inputs, ... }:
let wallpapersDir = "/home/rishabh/Pictures/Wallpapers"; in
{
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
  ];

  qt = {
    enable = true;
    platformTheme.name = lib.mkForce "gtk3";
  };

  programs.caelestia = {
    enable = true;
    settings = {
      general = {
        apps = {
          terminal = "ghostty";
          audio = "${pkgs.pwvucontrol}/bin/pwvucontrol";
        };
      };
      bar = {
        status = {
          showAudio = true;
        };
        workspaces = {
          activeIndicator = true;
          activeLabel = "";
          activeTrail = true;
          label = "";
          occupiedBg = false;
          occupiedLabel = "";
          perMonitorWorkspaces = true;
          rounded = true;
          showWindows = true;
          shown = 5;
        };
        tray = {
          background = true;
        };
        entries = [
          { id = "logo"; enabled = true; }
          { id = "workspaces"; enabled = true; }
          { id = "spacer"; enabled = true; }
          { id = "activeWindow"; enabled = true; }
          { id = "spacer"; enabled = true; }
          { id = "tray"; enabled = true; }
          { id = "statusIcons"; enabled = true; }
          { id = "clock"; enabled = true; }
          { id = "idleInhibitor"; enabled = true; }
          { id = "power"; enabled = true; }
        ];
      };
      border = {
        rounding = 10;
        thickness = 10;
      };
      services = {
        useFahrenheit = false;
        weatherLocation = "19.9973, 73.791";
        useTwelveHourClock = true;
        smartScheme = true;
      };
      launcher = {
        actionPrefix = "/";
        vimKeybinds = true;
      };
      paths = {
        wallpaperDir = wallpapersDir;
        sessionGif = "${self}/assets/bird.gif";
        # mediaGif = "${self}/assets/.gif";
      };
    };
    cli.enable = true;
  };

  wayland.windowManager.hyprland.settings.env = [
    "CAELESTIA_WALLPAPERS_DIR, ${wallpapersDir}"
  ];
}
