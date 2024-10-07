{ pkgs, ... }:
{
  services.xserver.desktopManager.kodi.enable = true;
  services.xserver.desktopManager.kodi.package = pkgs.kodi-gbm.withPackages (p: with p; [
    jellyfin
    pvr-iptvsimple
    vfs-sftp
    #osmc-skin
    inputstream-adaptive
    websocket
  ]);
}
