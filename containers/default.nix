# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{ ... }: {
  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    ./casa.nix
    ./bazarr.nix
    ./dockerproxy.nix
    ./duplicati.nix
    ./filebrowser.nix
    ./flaresolverr.nix
    ./homepage.nix
    ./jackett.nix
    ./jellyfin.nix
    ./jellyseerr.nix
    ./plex.nix
    ./portainer.nix
    ./prowlarr.nix
    ./qbittorrent.nix
    ./radarr.nix
    ./sonarr.nix
    ./suwayomi.nix
    ./watchstate.nix
  ];
}
