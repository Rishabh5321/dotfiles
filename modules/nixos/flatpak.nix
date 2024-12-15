_:
{
  services.flatpak = {
    enable = true;
    packages = [ 
      "org.dupot.easyflatpak"
       "tv.kodi.Kodi"
      ];
    update = {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "weekly"; # Default value
      };
    };
  };
}
