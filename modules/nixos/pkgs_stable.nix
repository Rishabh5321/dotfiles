{ pkgs-stable, ... }: {
  environment.systemPackages = with pkgs-stable; [
    #jellyfin-media-player
    #cliphist
  ];
}
