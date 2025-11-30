{ pkgs, config, ... }:


{

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
    ];
    settings.Theme = {
      CursorTheme = config.stylix.cursor.name;
      CursorSize = config.stylix.cursor.size;
    };
  };

  environment.systemPackages = [
    (
      pkgs.sddm-astronaut.override {
        themeConfig = with config.lib.stylix.colors.withHashtag; {
          Font = "JetBrainsMono";
          FontSize = "12";
          Background = "${config.stylix.image}";
          CropBackground = "false";
          BackgroundHorizontalAlignment = "center";
          BackgroundVerticalAlignment = "center";
          DimBackground = "0.0";
          HeaderTextColor = "${base07}";
          DateTextColor = "${base07}";
          TimeTextColor = "${base07}";

          FormBackgroundColor = "${base00}";
          BackgroundColor = "${base00}";
          DimBackgroundColor = "${base00}";

          LoginFieldBackgroundColor = "#${base00}";
          PasswordFieldBackgroundColor = "${base00}";
          LoginFieldTextColo = "${base0D}";
          PasswordFieldTestColor = "${base0D}";
          UserIconColor = "${base0D}";
          PasswordIconColor = "${base0D}";

          PlaceholderTextColor = "${base02}";
          WarningColor = "${base0A}";

          LoginButtonTextColor = "${base0D}";
          LoginButtonBackgroundColor = "${base00}";
          SystemButtonsIconsColor = "${base0D}";
          SessionButtonTextColor = "${base0D}";
          VirtualKeyboardButtonTextColor = "${base0D}";

          DropdownTextColor = "${base0D}";
          DropdownSelectedBackgroundColor = "${base00}";
          DropdownBackgroundColor = "${base00}";

          HighlightTextColor = "${base0D}";
          HighlightBackgroundColor = "${base0D}";
          HighlightBorderColor = "${base0D}";

          HoverUserIconColor = "${base0A}";
          HoverPasswordIconColor = "${base0A}";
          HoverSystemButtonsIconsColor = "${base0A}";
          HoverSessionButtonTextColor = "${base0A}";
          HoverVirtualKeyboardButtonTextColor = "${base0A}";

          PartialBlur = "true";
          BlurMax = "35";
          Blur = "2.0";

          HourFormat = "h:mm:ss AP";

          HaveFormBackground = "false";
          FormPosition = "left";

        };
      }
    )
  ];

  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.hyprlock.enableGnomeKeyring = true;
}
