# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "docker";

      containers = {
        prowlarr = {
          image = "lscr.io/linuxserver/prowlarr:latest";
          autoStart = true;
          ports = [ "9696:9696" ];
          volumes = [
            "/mnt/Docker/Docker/Prowlarr_Config:/config"
          ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "Asia/Kolkata";
          };
        };
      };
    };
  };
}
