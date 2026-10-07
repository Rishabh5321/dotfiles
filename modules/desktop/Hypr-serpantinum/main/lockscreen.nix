{ inputs, pkgs, username, ... }:
{
  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "hyprland"; # Or "hyprland" or "sway"
    package = inputs.dankMaterialShell.packages.${pkgs.stdenv.hostPlatform.system}.default;
    configHome = "/home/${username}";
  };
}
