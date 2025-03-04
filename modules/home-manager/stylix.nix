{ pkgs
, config
, ...
}: {
  gtk = {
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      #gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      #gtk-application-prefer-dark-theme = 1;
    };
    #theme = {
    #  name = "adw-gtk3-dark";
    #  package = pkgs.adw-gtk3;
    #};
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "breeze";
  };

  stylix.targets.waybar.enable = false;
  stylix.targets.rofi.enable = false;
  stylix.targets.wofi.enable = false;
  stylix.targets.hyprland.enable = false;
  #stylix.targets.kde.enable = true;
  #programs.gpg.enable = true;
  #stylix.targets.kitty.enable = false;

  services.gpg-agent.enable = true;
}
