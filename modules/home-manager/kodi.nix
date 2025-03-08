{ pkgs, ... }:

{
  # Home Manager Kodi configuration
  programs.kodi = {
    enable = true;
  };
  
  # Install Kodi plugins as separate packages
  home.packages = with pkgs.kodiPlugins; [
    jellyfin
    pvr-iptvsimple
    vfs-sftp
    inputstream-adaptive
    websocket
  ];
}