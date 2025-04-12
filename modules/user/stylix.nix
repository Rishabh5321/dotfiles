{ pkgs, config, ... }: {

  gtk = {
    enable = true;
    iconTheme = {
      name = "Tela";
      package = pkgs.tela-icon-theme;
    };
  };

  # Qt configuration
  qt = {
    enable = true;
    platformTheme.name = "qtct"; # Align with Stylix's supported platform
    style.name = "kvantum"; # Use Kvantum as the Qt style
  };

  # Stylix configuration
  stylix.targets.waybar.enable = false;
  stylix.targets.rofi.enable = false;
  stylix.targets.wofi.enable = false;
  stylix.targets.hyprland.enable = false;

  # Ensure Stylix's Qt platform is set to 'qtct'
  stylix.targets.qt.platform = "qtct";
}
