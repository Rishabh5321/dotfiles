{ pkgs-unstable, ... }: {
  environment.systemPackages = with pkgs-unstable; [
    brave
    google-chrome
    oh-my-posh
    jellyfin-media-player
    plex-media-player
    spotify
    stremio
    winetricks
    zed-editor
  ];
}
