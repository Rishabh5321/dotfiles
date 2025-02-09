_:
{
  services.flatpak = {
    enable = true;
    packages = [
      "org.dupot.easyflatpak"
      "tv.kodi.Kodi"
      "org.jdownloader.JDownloader"
      "com.github.iwalton3.jellyfin-media-player"
      "org.videolan.VLC"
      "io.mpv.Mpv"
    ];
    update = {
      auto = {
        enable = true;
        onCalendar = "weekly"; # Default value
      };
    };
  };
}
