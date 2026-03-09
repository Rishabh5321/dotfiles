{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [
        "gtk"
        "hyprland"
      ];
    };
  };
}
