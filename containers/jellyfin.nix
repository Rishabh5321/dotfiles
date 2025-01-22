# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "docker";

      containers = {
        jellyfin = {
          image = "lscr.io/linuxserver/jellyfin:latest";
          autoStart = true;
          ports = [
            "8096:8096"
            "8920:8920"
            "7359:7359/udp"
          ];
          devices = [
            "/dev/dri:/dev/dri"
          ];
          volumes = [
            "/mnt/Docker/Docker/JellyFin_Docker:/config"
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