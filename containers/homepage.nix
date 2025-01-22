# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "docker";

      containers = {
        homepage = {
          image = "ghcr.io/gethomepage/homepage:latest";
          autoStart = true;
          ports = [ "2500:3000" ];
          volumes = [
            "/mnt/Docker/Docker/HomePage_Config:/app/config"
            "/mnt/Raid:/mnt/Raid"
            "/mnt/test:/mnt/SSD"
            "/mnt/E_Disk:/mnt/E_Disk"
            "/var/run/docker.sock:/var/run/docker.sock"
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
