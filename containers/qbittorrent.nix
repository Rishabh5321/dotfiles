# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "docker";

      containers = {
        qbittorrent = {
          image = "lscr.io/linuxserver/qbittorrent:latest";
          autoStart = true;
          ports = [
            "8080:8080"
            "6881:6881"
            "6881:6881/udp"
          ];
          volumes = [
            "/mnt/Docker/Docker/Qbittorrent_Config:/config"
            "/mnt/Docker/Downloads:/downloads"
            "/mnt/Raid/Downloads:/downloads1"
            "/mnt/E_Disk/Games:/Games"
          ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "Asia/Kolkata";
            WEBUI_PORT = "8080";
            TORRENTING_PORT = "6881";
          };
        };
      };
    };
  };
}
