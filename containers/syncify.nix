_: {
  virtualisation = {
    oci-containers = {
      backend = "podman";

      containers = {
        syncify = {
          image = "thewicklowwolf/syncify:latest";
          autoStart = true;
          ports = [ "5000:5000" ];
          volumes = [
            "/mnt/Docker/Docker/Syncify_Config:/syncify/config"
            "/mnt/Raid/Learn/Bonus/Music:/syncify/downloads"
            "/etc/localtime:/etc/localtime:ro"
          ];
          environment = {
            TZ = "Asia/Kolkata";
            thread_limit = "5";
            crop_album_art = "false";
          };
          pull = "newer";
        };
      };
    };
  };
}
