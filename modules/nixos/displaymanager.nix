{
  lib,
  wallpaper,
  config,
  ...
}: {
  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      sugarCandyNix = {
        enable = false; # This set SDDM's theme to "sddm-sugar-candy-nix".
        settings = {
          # Set your configuration options here.
          # Here is a simple example:
          Background = lib.cleanSource ../../wallpapers/${wallpaper};
          ScreenWidth = 1920;
          ScreenHeight = 1080;
          FormPosition = "left";
          HaveFormBackground = false;
          PartialBlur = true;
          HourFormat = "h:m:s ap";
          #MainColor = "#${config.stylix.base16Scheme.base03}";
          AccentColor = "#${config.stylix.base16Scheme.base04}";
          #BackgroundColor = "#${config.stylix.base16Scheme.base03}";
          # ...
        };
      };
      #  settings = {
      #    Autologin = {
      #      Session = "hyprland";
      #      User = "${username}";
      #    };
      #  };
      #theme = "${import ./pkgs/sddm-astronaut-theme.nix { inherit pkgs; }}";
      autoNumlock = true;
      theme = "sddm-sugar-candy-nix";
      #theme = "where_is_my_sddm_theme";
    };
  };

  #services.xserver.displayManager.lightdm.enable = true;

  #services.libinput.enable = true;
}
