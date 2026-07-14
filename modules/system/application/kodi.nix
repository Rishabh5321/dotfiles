{ pkgs, ... }: {
  services.xserver.desktopManager.kodi = {
    enable = true;
    package = pkgs.kodi-wayland.withPackages (p: with p; [
      inputstreamhelper
      inputstream-adaptive
      inputstream-ffmpegdirect
      inputstream-rtmp
      vfs-libarchive
      vfs-rar
      youtube
    ]);
  };
}
