_:
{
  services.flatpak = {
    enable = true;
    packages = [
      "com.github.iwalton3.jellyfin-media-player"
      "com.stremio.Stremio"
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
