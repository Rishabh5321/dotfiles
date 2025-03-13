{pkgs, ...}:{
  services.xserver.desktopManager.kodi = {
      enable = true;
      package = pkgs.kodi.withPackages (p: with p; [ inputstream-adaptive ]);
    };
}