{ lib
, pkgs
, ...
}: {
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
    platformTheme.name = "gtk";
    style.name = "adwaita";
    style.package = pkgs.adwaita-qt;
  };
  home.sessionVariables = {
    # QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
    QT_PLUGIN_PATH = lib.concatStringsSep ":" [
      "${pkgs.qt5.qtbase}/${pkgs.qt5.qtbase.qtPluginPrefix}"
      "${pkgs.qt5.qtwayland.bin}/${pkgs.qt5.qtbase.qtPluginPrefix}"
      "${pkgs.qt6.qtwayland}/lib/qt-6/plugins"
      "${pkgs.qt6.qtbase}/${pkgs.qt6.qtbase.qtPluginPrefix}"
    ];
  };
  stylix.targets.waybar.enable = false;
  stylix.targets.rofi.enable = false;
  stylix.targets.hyprland.enable = false;
  #stylix.targets.kde.enable = true;
  #programs.gpg.enable = true;
  #stylix.targets.kitty.enable = false;

  services.gpg-agent.enable = true;
}
