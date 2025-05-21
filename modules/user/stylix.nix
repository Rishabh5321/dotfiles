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
  stylix.targets.spicetify.enable = false;
  #stylix.enableReleaseChecks = false; # Will have to remove after the stylix 25.05 is released.
}
