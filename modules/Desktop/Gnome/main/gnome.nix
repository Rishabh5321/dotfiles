# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
_: {
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services = {
    # Browser integration
    gnome.gnome-browser-connector.enable = true;
  };
}
