# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "podman";

      containers = {
        radarr = {
          image = "lscr.io/linuxserver/radarr:latest";
          autoStart = true;
          ports = [ "7878:7878" ];
          volumes = [
            "/mnt/Docker/Docker/Radarr_Config:/config"
            "/mnt/Raid/Learn/Bonus:/data"
            "/mnt/Raid/Downloads:/downloads"
            #"/mnt/Raid/Downloads:/downloads1"
            "/mnt/E_Disk/Learn/Bonus:/data1"
          ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "Asia/Kolkata";
          };
          pull = "newer";
        };
      };
    };
  };
}
