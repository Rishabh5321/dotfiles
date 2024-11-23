# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
_: {
  services = {
    displayManager.sddm.enable = true;
    desktopManager.kde.enable = true;
  };
}
