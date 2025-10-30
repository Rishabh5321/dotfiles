{
  pkgs,
  wallpaper,
  wallpapers,
  ...
}:
{
  stylix = {
    enable = true;
    image = "${wallpapers}/${wallpaper}";
    polarity = "dark";

    cursor = {
      package = pkgs.afterglow-cursors-recolored;
      name = "Afterglow-Recolored-Catppuccin-Flamingo";
      size = 24;
    };

    fonts = {

      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };

      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };

      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    opacity = {
      applications = 1.0;
      popups = 1.0;
      terminal = 1.0;
      desktop = 1.0;
    };

    targets = {
      font-packages.enable = true;
    };
  };

  gtk.iconCache.enable = true;
}
