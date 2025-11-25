{ pkgs, inputs, ... }:
{
  programs.hyprland = {
    enable = true;
    #withUWSM = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # programs.uwsm.enable = true;
}
