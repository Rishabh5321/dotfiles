{ lib, config, ... }:
{
  # programs.noctalia-shell.settings = {
  #   templates = lib.mapAttrs (_: _: lib.mkForce true) {
  #     alacritty = false;
  #     code = false;
  #     discord = false;
  #     discord_armcord = false;
  #     discord_dorion = false;
  #     discord_equibop = false;
  #     discord_lightcord = false;
  #     discord_vesktop = false;
  #     discord_webcord = false;
  #     enableUserTemplates = false;
  #     foot = false;
  #     fuzzel = false;
  #     ghostty = false;
  #     gtk = false;
  #     kcolorscheme = false;
  #     kitty = false;
  #     pywalfox = false;
  #     qt = false;
  #     vicinae = false;
  #     walker = false;
  #   };
  # };

  systemd.user.services.noctalia-shell = {
    Unit.After = [ "graphical-session.target" ];
    Service = {
      Environment = lib.mkForce [
        # "PATH=$PATH:/usr/bin:/bin:/run/current-system/sw/bin:/etc/profiles/per-user/${config.home.username}/bin:${config.home.profileDirectory}/bin"
        "XDG_DATA_DIRS=${config.home.homeDirectory}/.nix-profile/share:${config.home.homeDirectory}/.local/share:/usr/local/share:/usr/share"
        # "GDK_PIXBUF_MODULE_FILE=${pkgs.librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache"
        # "QT_PLUGIN_PATH=${pkgs.kdePackages.qtsvg}/lib/qt-6/plugins:${pkgs.libsForQt5.qtsvg}/lib/qt-5/plugins"
        # "XCURSOR_PATH=${config.home.homeDirectory}/.icons:${config.home.homeDirectory}/.local/share/icons:/usr/share/icons:/usr/share/pixmaps"

        # FORCE NOCTALIA TO USE PAPIRUS
        # "QS_ICON_THEME=Papirus-Dark"
      ];
    };
  };
}
