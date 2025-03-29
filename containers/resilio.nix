{
  virtualisation = {
    oci-containers = {
      backend = "podman";

      containers = {
        resilio-sync = {
          image = "lscr.io/linuxserver/resilio-sync:latest";
          autoStart = true;
          ports = [
            "8888:8888"
            "55555:55555"
          ];
          volumes = [
            "/mnt/Docker/Docker/Resilio_Config:/config"
            "/mnt/Raid/Downloads:/downloads"
            "/mnt/Raid/Learn/Bonus/Music:/sync"
          ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "Asia/Kolkata";
          };
          pull = "newer"; # Podman uses autoPull, not
        };
      };
    };
  };
}
