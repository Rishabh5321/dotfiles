{ pkgs, ... }: {
  gtk = {
    enable = true;

    iconTheme = {
      name = "Tela";
      package = pkgs.tela-icon-theme;
    };

    theme = {
      name = "adw-gtk3";
      # package = pkgs.adw-gtk3;
    };
  };

  stylix.targets = {
    waybar.enable = false;
    rofi.enable = false;
    wofi.enable = false;
    hyprland.enable = false;
    # spicetify.enable = false;
  };
}
