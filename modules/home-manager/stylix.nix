{ pkgs, ... }: {
  gtk = {
    iconTheme = {
      name = "Tela-blue";
      package = pkgs.tela-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  qt = {
    enable = true;
    style.name = "Adw-gtk3";
    platformTheme.name = "gtk3";
  };
  #stylix.targets.waybar.enable = false;
  stylix.targets.rofi.enable = false;
  #stylix.targets.hyprland.enable = false;
  stylix.targets.kde.enable = true;
  #programs.gpg.enable = true;

  #services.gpg-agent.enable = true;
}
