# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
_: {
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
  };
}
