# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "podman";

      containers = {
        suwayomi = {
          image = "ghcr.io/suwayomi/tachidesk:preview";
          autoStart = true;
          ports = [ "4567:4567" ];
          volumes = [
            "/mnt/Docker/Docker/Tachiyomi_Config:/home/suwayomi/.local/share/Tachidesk"
          ];
          environment = {
            TZ = "Asia/Kolkata";
            FLARESOLVERR_ENABLED = "true";
            FLARESOLVERR_URL = "http://flaresolverr:8191";
          };
          pull = "newer";
        };
      };
    };
  };
}
