_:
{
  gtk = {
    enable = true;

    # iconTheme = {
    #   enable = true;
    #   package = pkgs.papirus-icon-theme;
    # };

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
      qt.platform = "qtct";
      hyprland.enable = false;
      swaylock.enable = false;
      hyprpanel.enable = false;
      # zed.enable = true;
      dank-material-shell.enable = false;
      zen-browser.enable = false;
      # spicetify.enable = false;
    };
  };
}
