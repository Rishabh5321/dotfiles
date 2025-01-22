# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "docker";

      containers = {
        watchstate = {
          image = "ghcr.io/arabcoders/watchstate:latest";
          autoStart = true;
          user = "0:0";
          ports = [
            "8500:8080"
            "8600:9000"
          ];
          volumes = [
            "/mnt/Docker/Docker/Watchstate_Config:/config:rw"
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