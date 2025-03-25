{ pkgs, config, ... }: {
  gtk = {
    iconTheme = {
      name = "Qogir";
      package = pkgs.qogir-icon-theme;
    };
    gtk3.extraConfig = {
      #gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      #gtk-application-prefer-dark-theme = 1;
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
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
