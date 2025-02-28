_:
{
  services.flatpak = {
    enable = true;
    packages = [
      "org.dupot.easyflatpak"
      "tv.kodi.Kodi"
      "org.jdownloader.JDownloader"
      "com.github.iwalton3.jellyfin-media-player"
      "io.github.giantpinkrobots.varia"
      "info.febvre.Komikku"
    ];
    overrides = {
      global = {
        # Force Wayland by default
        Context.sockets = [
          "wayland"
          "!x11"
          "!fallback-x11"
        ];
      };
    };
    update = {
      auto = {
        enable = true;
        onCalendar = "weekly"; # Default value
      };
    };
  };
}
