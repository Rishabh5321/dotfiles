{ pkgs, inputs, ... }:
{
  programs.hyprland = {
    enable = true;
    #withUWSM = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  # programs.uwsm.enable = true;
}
