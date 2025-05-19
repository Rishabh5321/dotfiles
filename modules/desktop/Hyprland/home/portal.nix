{ inputs, pkgs, ... }:
{

  # xdg.portal = {
  #   enable = true;
  #   xdgOpenUsePortal = true;
  #   config = {
  #     common.default = [ "hyprland" ];
  #     hyprland.default = [
  #       "gtk"
  #       "hyprland"
  #     ];
  #   };
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal
  #     pkgs.xdg-desktop-portal-gtk
  #     pkgs.xdg-desktop-portal-wlr
  #     inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
  #   ];
  # };

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
    };
    portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-hyprland];
      configPackages = [pkgs.hyprland];
    };
  };

}
