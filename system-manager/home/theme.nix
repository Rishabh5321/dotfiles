{ wallpapers, wallpaper, pkgs, lib, options, config, ... }:
let
  hasStylix = options ? stylix;
  stylixEnabled = if hasStylix then config.stylix.enable else false;
in
{
  config = lib.mkMerge [
    {
      gtk = {
        enable = lib.mkForce false;

        # iconTheme = {
        #   enable = true;
        #   package = pkgs.papirus-icon-theme;
        # };

        theme = {
          name = "adw-gtk3";
        };
      };
    }
    (lib.optionalAttrs hasStylix {
      stylix = {
        enable = lib.mkOptionDefault false;

        image = lib.mkIf stylixEnabled "${wallpapers}/${wallpaper}";
        polarity = lib.mkIf stylixEnabled "dark";

        icons = lib.mkIf stylixEnabled {
          enable = true;
          package = pkgs.papirus-icon-theme;
          dark = "Papirus-Dark";
          light = "Papirus-Light";
        };

        opacity = lib.mkIf stylixEnabled {
          applications = 1.0;
          popups = 1.0;
          terminal = 1.0;
          desktop = 1.0;
        };

        targets = lib.mkIf stylixEnabled {
          font-packages.enable = false;
          gtk.enable = false;
          waybar.enable = false;
          rofi.enable = false;
          wofi.enable = false;
          qt.enable = true;
          qt.platform = "qtct";
          hyprland.enable = false;
          swaylock.enable = false;
          dank-material-shell.enable = false;
          hyprpanel.enable = false;
          # zed.enable = true;
          zen-browser.enable = false;
          # spicetify.enable = false;
        };
      };
    })
  ];
}
