_: {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      enable-hot-corners = false;
      show-battery-percentage = true;
    };

    # Use capslock as super key
    "org/gnome/desktop/input-sources" = {
      xkb-options = [
        "win:super"
        "numpad:mac" # always enable numlock
        "f:XF86AudioRaiseVolume"
      ];
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };

    "org/gnome/desktop/background" = {
      #picture-uri="file:///home/${username}/Pictures/Wallpapers/${wallpaper}";
    };

    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };

    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
      event-sounds = false;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      toggle-fullscreen = [ "<Super>f" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-applications = [ "<Super>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];
      switch-to-workspace-left = [ "<Control><Super>Left" ];
      switch-to-workspace-right = [ "<Control><Super>Right" ];
    };

    "org/gnome/shell/keybindings" = {
      toggle-application-view = [ "<Shift><Super>Return" ];
    };

    "org/gnome/mutter" = {
      overlay-key = "Super_L";
      edge-tiling = true;
      dynamic-workspaces = true;
      workspaces-only-on-primary = false;
      auto-maximize = false;
    };

    "org/gnome/shell" = {
      disable-extension-version-validation = true;
      disable-user-extensions = false;
      favorite-apps = [
        "kitty.desktop"
        "Alacritty.desktop"
        "zen.desktop"
        "brave-browser.desktop"
        "google-chrome.desktop"
        "org.gnome.Nautilus.desktop"
        "discord.desktop"
        "spotify.desktop"
        "cursor.desktop"
        "code.desktop"
        "com.github.iwalton3.jellyfin-media-player.desktop"
        "smartcode-stremio.desktop"
        "plexmediaplayer.desktop"
        "github-desktop.desktop"
        "obsidian.desktop"
        "tv.kodi.Kodi.desktop"
        "beeper.desktop"
        "ca.desrt.dconf-editor.desktop"
        "com.heroicgameslauncher.hgl.desktop"
        "firefox.desktop"
        "org.telegram.desktop.desktop"
        "dev.zed.Zed.desktop"
      ];
    };
  };
}
