_: {
  virtualisation = {
    oci-containers = {
      backend = "podman";

      containers = {
        jackett = {
          image = "lscr.io/linuxserver/jackett:latest";
          autoStart = true;
          ports = [ "9117:9117" ];
          volumes = [
            "/mnt/Docker/Docker/Jackett_Config:/config"
            "/mnt/Docker/Downloads:/downloads"
            "/mnt/Raid/Downloads:/downloads1"
          ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            AUTO_UPDATE = "true";
            TZ = "Asia/Kolkata";
          };
          pull = "newer";
        };
      };
    };
  };
}
