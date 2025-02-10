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
    ];
    update = {
      auto = {
        enable = true;
        onCalendar = "weekly"; # Default value
      };
    };
  };
}
