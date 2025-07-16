{ pkgs, inputs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = pkgs.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.uwsm.enable = true;
}
