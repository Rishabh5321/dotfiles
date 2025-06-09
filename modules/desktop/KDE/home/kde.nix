{ lib, ... }:
{
  stylix.targets.qt.platform = "qtct";
  # stylix.targets.kde.enable = true;
  # Qt configuration
  qt = {
    enable = lib.mkForce false;
    #platformTheme.name = "kde"; # Align with Stylix's supported platform
    #style.name = "breeze";
  };
}
