# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "docker";

      containers = {
        portainer = {
          image = "portainer/portainer-ce:latest";
          autoStart = true;
          ports = [
            "8000:8000"
            "9443:9443"
            "9000:9000"
          ];
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "/portainer_data:/data"
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
