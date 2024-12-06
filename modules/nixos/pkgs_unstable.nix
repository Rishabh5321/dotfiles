{ pkgs-unstable, ... }: {
  environment.systemPackages = with pkgs-unstable; [
    jellyfin-media-player
    plex-media-player
    #cliphist
  ];
}
