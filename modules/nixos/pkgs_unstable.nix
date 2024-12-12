{ pkgs-unstable, ... }: {
  environment.systemPackages = with pkgs-unstable; [
    brave
    dconf-editor
    gnome-tweaks
    google-chrome
    heroic
    jellyfin-media-player
    lutris
    oh-my-posh
    plex-media-player
    protonup-qt
    spotify
    stremio
    winetricks
    zed-editor
  ];
}
