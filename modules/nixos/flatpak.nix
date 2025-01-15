_:
{
  services.flatpak = {
    enable = true;
    packages = [
      "org.dupot.easyflatpak"
      "tv.kodi.Kodi"
      "org.jdownloader.JDownloader"
    ];
    update = {
      auto = {
        enable = true;
        onCalendar = "weekly"; # Default value
      };
    };
  };
}
