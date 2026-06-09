{ lib, config, options, pkgs, ... }:
let
  hasStylix = options ? stylix;
  stylixEnabled = hasStylix && config.stylix.enable;
in
{
  config = lib.mkMerge [
    {
      gtk = {
        enable = true;
        theme = if stylixEnabled then {
          name = "adw-gtk3";
          package = pkgs.adw-gtk3;
        } else {
          name = "Nordic-darker";
          package = pkgs.nordic;
        };
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
        colorScheme = "dark";
        cursorTheme = {
          package = pkgs.capitaine-cursors;
          name = "capitaine-cursors";
          size = 16;
        };
        gtk4.theme = config.gtk.theme;
      };

      qt = {
        enable = true;
      };
    }
    (lib.optionalAttrs hasStylix {
      stylix.enable = lib.mkOptionDefault false;

      stylix.targets = lib.mkIf config.stylix.enable {
        waybar.enable = false;
        rofi.enable = false;
        wofi.enable = false;
        gtk.enable = false;
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
    })
  ];
}
