{ ... }: {
  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    #./casa.nix
    ./bazarr.nix
    #./dockerproxy.nix
    #./duplicati.nix
    ./filebrowser.nix
    ./flaresolverr.nix
    ./homepage.nix
    ./jackett.nix
    ./jellyfin.nix
    ./jellyseerr.nix
    #./plex.nix
    ./portainer.nix
    ./prowlarr.nix
    ./qbittorrent.nix
    ./radarr.nix
    ./resilio.nix
    ./sonarr.nix
    ./suwayomi.nix
    ./syncify.nix
    #./watchstate.nix
  ];
}
