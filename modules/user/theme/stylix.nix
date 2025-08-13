{ pkgs, ... }: {
  gtk = {
    enable = true;

    iconTheme = {
      name = "Tela";
      package = pkgs.tela-icon-theme;
    };

    theme = {
      name = "adw-gtk3";
    };
  };

  qt = {
    enable = true;
    # platformTheme.name = "qtct"; # Align with Stylix's supported platform
    # style.name = "kvantum"; # Use Kvantum as the Qt style
  };

  stylix = {
    targets = {
      waybar.enable = false;
      rofi.enable = false;
      wofi.enable = false;
      qt.enable = true;
      # qt.platform = "qtct";
      hyprland.enable = false;
      # swaylock.enable = false;
      zed.enable = false;
      # spicetify.enable = false;
    };
  };
}
