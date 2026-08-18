{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config = {
      common.default = [
        "gtk"
      ];
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
      };
    };
  };
}
