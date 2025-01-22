# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "docker";

      containers = {
        bazarr = {
          image = "lscr.io/linuxserver/bazarr:latest";
          autoStart = true;
          ports = ["6767:6767"];
          volumes = [
            "/mnt/Docker/Docker/Bazarr_Docker:/config"
            "/mnt/Raid/Learn/Bonus:/data"
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