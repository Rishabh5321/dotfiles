{ pkgs
, wallpaper
, wallpapers
, ...
}: {
  stylix = {
    enable = true;
    image = "${wallpapers}/${wallpaper}";
    polarity = "dark";
    opacity.terminal = 1.0;

    cursor = {
      package = pkgs.afterglow-cursors-recolored;
      name = "Afterglow-Recolored-Catppuccin-Flamingo";
      size = 24;
    };
    fonts = {

      serif = {
        package = pkgs.aleo-fonts;
        name = "Aleo";
      };

      sansSerif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto Sans CJK JP";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono NFM";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
  };

  gtk.iconCache.enable = true;
}
