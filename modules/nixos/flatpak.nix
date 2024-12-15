_:
{
  # Optionally, set up Flatpak permissions
  services.flatpak.enable = true;

  services.flatpak.packages = [
    "org.dupot.easyflatpak"
    "tv.kodi.Kodi"
  ];
}
