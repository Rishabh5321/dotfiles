# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "docker";

      containers = {
        sonarr = {
          image = "lscr.io/linuxserver/sonarr:latest";
          autoStart = true;
          ports = [ "8989:8989" ];
          volumes = [
            "/mnt/Docker/Docker/Sonarr_Config:/config"
            "/mnt/Raid/Learn/Bonus:/data"
            "/mnt/Docker/Downloads:/downloads"
            "/mnt/Raid/Downloads:/downloads1"
            "/mnt/E_Disk/Learn/Bonus:/data1"
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
