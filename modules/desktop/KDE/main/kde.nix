# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
_: {
  services = {
    desktopManager.plasma6.enable = true;
    displayManager = {
      enable = true;
      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };
      };
    };
  };
}
