{ pkgs-unstable, ... }: {
  environment.systemPackages = with pkgs-unstable; [
    oh-my-posh
    jellyfin-media-player
    plex-media-player
    #cliphist
  ];
}
