{
  virtualisation = {
    oci-containers = {
      backend = "podman"; # Change backend to podman

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
            "/mnt/Raid/Downloads:/downloads"
            "/mnt/Raid/Learn/Bonus:/mnt/Raid/Learn/Bonus"
          ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "Asia/Kolkata";
            WEBUI_PORT = "8080";
            TORRENTING_PORT = "6881";
          };
          pull = "newer";
        };
      };
    };
  };
}