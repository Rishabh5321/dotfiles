{ pkgs, ... }: {

  gtk = {
    enable = true;
    iconTheme = {
      name = "Tela";
      package = pkgs.tela-icon-theme;
    };
    theme = {
      name = "adw-gtk3";
      #package = pkgs.adw-gtk3;
    };
  };

  # Stylix configuration
  stylix.targets.waybar.enable = false;
  stylix.targets.rofi.enable = false;
  stylix.targets.wofi.enable = false;
  stylix.targets.hyprland.enable = false;
}
