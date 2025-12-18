{ inputs, username, ... }:
{
  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "hyprland"; # Or "hyprland" or "sway"

    configHome = "/home/${username}";
  };
}
