{ pkgs
, #pkgs,
  ...
}: {
  programs.gnome-shell = {
    enable = true;
    extensions = [
      { package = pkgs.gnomeExtensions.appindicator; }
      { package = pkgs.gnomeExtensions.caffeine; }
      { package = pkgs.gnomeExtensions.clipboard-indicator; }
      { package = pkgs.gnomeExtensions.user-themes; }
      { package = pkgs.gnomeExtensions.alphabetical-app-grid; }
      { package = pkgs.gnomeExtensions.system-monitor; }
      { package = pkgs.gnomeExtensions.dash-to-dock; }
      { package = pkgs.gnomeExtensions.gsconnect; }
      { package = pkgs.gnomeExtensions.pop-shell; }
      { package = pkgs.gnomeExtensions.unite; }
      { package = pkgs.gnomeExtensions.blur-my-shell; }
      #{package = pkgs-unstable.gnome-shell-extension-tilingnome-unstable;}
    ];
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "org/gnome/shell/extensions/dash-to-dock"
      ];
    };

    "org/gnome/shell/extensions/appindicator" = {
      icon-brightness = -0.1;
      icon-opacity = 255;
      icon-saturation = 0.8;
      icon-size = 18;
      tray-pos = "right";
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    # "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
    #   blur = true;
    #   brightness = 0.6;
    #   sigma = 30;
    #   static-blur = true;
    #   style-dash-to-dock = 5;
    # };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
      brightness = 0.6;
      sigma = 0;
      static-blur = false;
      style-panel = 3;
    };

    "org/gnome/shell/extensions/caffeine" = {
      indicator-position = -1;
      indicator-position-index = -1;
      screen-blank = "never";
      show-indicator = "only-active";
      show-notifications = false;
      toggle-shortcut = [ "<Super>c" ];
    };

    "org/gnome/shell/extensions/clipboard-indicator" = {
      cache-size = 10;
      disable-down-arrow = false;
      display-mode = 0;
      history-size = 200;
      strip-text = true;
      topbar-preview-size = 8;

      clear-history = [ ];
      private-mode-binding = [ ];
      toggle-menu = [ "<Super><Control>v" ];
    };

    "org/gnome/shell/extensions/alphabetical-app-grid" = {
      folder-order-position = "alphabetical";
      logging-enabled = false;
      show-favourite-apps = false;
      sort-folder-contents = true;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-fixed = false;
      intellihide-mode = "1";
      dash-max-icon-size = 48;
      dodge-windows = true;
      intellihide = true;
      dock-position = "BOTTOM";
      dash-show-apps = true;
      dash-show-favorites = true;
      dash-show-running = true;
      dash-show-home = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "mouse";
    };

    "org/gnome/shell/extensions/gsconnect" = {
      enable = true;
    };

    "org/gnome/shell/extensions/unite" = {
      extend-left-box = false;
      greyscale-tray-icons = false;
      hide-app-menu-icon = true;
      use-activities-text = true;
    };

    "org/gnome/shell/extensions/pop-shell" = {
      active-hint = true;
      tile-by-default = true;
    };
  };
}
