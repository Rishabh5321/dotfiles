{ pkgs, ... }:

{
  programs.kodi = {
    enable = true;
    package = pkgs.kodi;
    
    # Enabling the specified plugins
    addons = with pkgs.kodi-addons; [
      jellyfin
      pvr-iptvsimple
      vfs-sftp
      inputstream-adaptive
      websocket
    ];
  };
}