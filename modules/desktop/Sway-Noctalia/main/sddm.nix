{ pkgs, config, lib, username, ... }:

let
  stylixEnabled = config ? stylix && config.stylix.enable;
in
{

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      # kdePackages.qt6-declarative
      kdePackages.qtsvg
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
    ];
    settings = {
      Autologin = {
        Session = "sway";
        User = "${username}";
      };
      Theme = lib.mkIf stylixEnabled {
        CursorTheme = config.stylix.cursor.name;
        CursorSize = config.stylix.cursor.size;
      };
    };
  };

  environment.systemPackages = [
    (if stylixEnabled then
      let
        colors = config.lib.stylix.colors.withHashtag;
      in
      pkgs.sddm-astronaut.override {
        themeConfig = {
          Background = "${config.stylix.image}";
          CursorColor = colors.base05;
          FullBlur = "true";
          PartialBlur = "true";
          HeaderTextColor = colors.base05;
          HaveFormBackground = "false";
          FormPosition = "left";
        };
      }
    else
      pkgs.sddm-astronaut)
  ];

  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.hyprlock.enableGnomeKeyring = true;
}
