# SDDM is a display manager for X11 and Wayland
{ pkgs
, config
, lib
, wallpaper
, wallpapers
, ...
}:
let
  textColor = config.stylix.base16Scheme.base05;
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura";
    themeConfig = {
      FormPosition = "left";
      Blur = "4.0";
      Background = "${lib.cleanSource wallpapers}/${wallpaper}";
      HeaderTextColor = "#${textColor}";
      DateTextColor = "#${textColor}";
      TimeTextColor = "#${textColor}";
      LoginFieldTextColor = "#${textColor}";
      PasswordFieldTextColor = "#${textColor}";
      UserIconColor = "#${textColor}";
      PasswordIconColor = "#${textColor}";
      WarningColor = "#${textColor}";
      LoginButtonBackgroundColor = "#${config.stylix.base16Scheme.base01}";
      SystemButtonsIconsColor = "#${textColor}";
      SessionButtonTextColor = "#${textColor}";
      VirtualKeyboardButtonTextColor = "#${textColor}";
      DropdownBackgroundColor = "#${config.stylix.base16Scheme.base01}";
      HighlightBackgroundColor = "#${textColor}";
      FormBackgroundColor = "#${config.stylix.base16Scheme.base01}";
    };
  };
in
{
  services.displayManager = {
    sddm = {
      package = pkgs.kdePackages.sddm;
      extraPackages = [ sddm-astronaut ];
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
    };
  };

  environment.systemPackages = [ sddm-astronaut ];


  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.hyprlock.enableGnomeKeyring = true;

  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xset}/bin/xset s off
    ${pkgs.xorg.xset}/bin/xset -dpms
    ${pkgs.xorg.xset}/bin/xset dpms 0 0 60
  '';
}
