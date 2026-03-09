{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    portalPackage =
      pkgs.xdg-desktop-portal-hyprland;
  };
}
