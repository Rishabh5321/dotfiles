# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "docker";

      containers = {
        jellyseerr = {
          image = "fallenbagel/jellyseerr:latest";
          autoStart = true;
          ports = [ "5055:5055" ];
          volumes = [
            "/mnt/Docker/Docker/Jellyseer_Config:/app/config"
          ];
          environment = {
            LOG_LEVEL = "debug";
            TZ = "Asia/Kolkata";
          };
        };
      };
    };
  };
}
