{ pkgs, config, lib, ... }:

let
  stylixEnabled = config ? stylix && config.stylix.enable;
in
{

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      # kdePackages.qt6-declarative
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
    ];
    settings = {
      # Autologin = {
      #   Session = "hyprland";
      #   User = "${username}";
      # };
      Theme = lib.mkIf stylixEnabled {
        CursorTheme = config.stylix.cursor.name;
        CursorSize = config.stylix.cursor.size;
      };
    };
  };

  programs.qylock = {
    enable = true;
    theme = "material-you-dark";
    sddm.enable = true;
    quickshell.enable = false;
  };

  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.hyprlock.enableGnomeKeyring = true;
}
