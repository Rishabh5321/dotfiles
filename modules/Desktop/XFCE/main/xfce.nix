# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
_: {
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.blueman.enable = true;
}
