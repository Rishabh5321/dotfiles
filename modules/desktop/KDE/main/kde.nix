{ pkgs, config, lib, wallpaper, ... }: {
  services = {
    desktopManager.plasma6.enable = true;
    displayManager = {
      enable = true;
      sddm = {
        enable = true;
        wayland = {
          enable = true;
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
            AccentColor = "#${config.stylix.base16Scheme.base0B}";
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
  };
}
