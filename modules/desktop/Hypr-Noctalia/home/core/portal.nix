{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
    configPackages = [ pkgs.hyprland ];
    # config = {
    #   common.default = [
    #     "gtk"
    #     "hyprland"
    #   ];
    # };
  };
}
