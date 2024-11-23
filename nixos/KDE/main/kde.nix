# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
_: {
  services = {
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };
}
