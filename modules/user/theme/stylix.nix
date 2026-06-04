{ lib, config, options, ... }:
let
  hasStylix = options ? stylix;
in
{
  config = lib.mkMerge [
    {
      gtk = {
        enable = true;
        theme = {
          name = "adw-gtk3";
        };
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
