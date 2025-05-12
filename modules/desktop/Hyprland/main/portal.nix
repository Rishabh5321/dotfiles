{ inputs, pkgs, ... }:
{

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "hyprland" ];
      hyprland.default = [
        #"gtk"
        "hyprland"
      ];
    };
    extraPortals = [
      #pkgs.xdg-desktop-portal-gtk
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
    ];
  };

}
