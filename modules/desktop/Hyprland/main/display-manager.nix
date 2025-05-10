{pkgs ,lib ,wallpaper, ... }: {
  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      wayland = {
        enable = false;
      };
      # package = pkgs.kdePackages.sddm;
      # extraPackages = with pkgs; [
      #   kdePackages.qtsvg
      #   kdePackages.qtmultimedia
      #   kdePackages.qtvirtualkeyboard
      # ];
      # theme = "sddm-astronaut-theme";
      # settings = {
      #   Autologin = {
      #     Session = "hyprland";
      #     User = "rishabh";
      #   };
      # };
      sugarCandyNix = {
        enable = true;
        settings = {
          # General settings
          Background = lib.cleanSource ../../../../wallpapers/${wallpaper};
          Font = "JetBrainsMono Nerd Font Mono";
          # Form settings
          HeaderText = "Welcome!";
          FormPosition = "left";
          HaveFormBackground = true;
          PartialBlur = true;
          HourFormat = "h:m:s ap";
        };
      };
      autoNumlock = true;
    };
  };

  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xset}/bin/xset s off
    ${pkgs.xorg.xset}/bin/xset -dpms
    ${pkgs.xorg.xset}/bin/xset dpms 0 0 60
  '';
}