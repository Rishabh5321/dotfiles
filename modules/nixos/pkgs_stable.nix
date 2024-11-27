{ pkgs-stable, ... }: {
  environment.systemPackages = with pkgs-stable; [
    jellyfin-media-player
    plex-media-player
    #cliphist
  ];
}
