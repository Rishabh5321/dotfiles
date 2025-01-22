# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "docker";

      containers = {
        plex = {
          image = "lscr.io/linuxserver/plex:latest";
          autoStart = true;
          devices = [
            "/dev/dri:/dev/dri"
          ];
          ports = [
            "32400:32400"
            "1900:1900/udp"
            "8324:8324"
            "32410:32410/udp"
            "32412:32412/udp"
            "32413:32413/udp"
            "32414:32414/udp"
            "32469:32469"
          ];
          volumes = [
            "/mnt/Docker/Docker/Plex_Config:/config"
            "/mnt/Raid/Learn/Bonus:/data"
            "/mnt/E_Disk/Learn/Bonus:/data1"
          ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "Asia/Kolkata";
            VERSION = "docker";
          };
        };
      };
    };
  };
}
