_:
{
  services.flatpak = {
    enable = true;
    packages = [
      # "com.github.iwalton3.jellyfin-media-player"
      "tv.kodi.Kodi"
      # "com.stremio.Stremio"
      "io.github.giantpinkrobots.varia"
    ];
    update = {
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };

  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
}
