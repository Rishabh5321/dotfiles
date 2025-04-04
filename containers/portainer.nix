_: {
  virtualisation = {
    oci-containers = {
      backend = "podman";

      containers = {
        portainer = {
          image = "portainer/portainer-ce:lts";
          autoStart = true;
          privileged = true;
          #restartPolicy = "always";
          ports = [
            "8000:8000"
            "9443:9443"
          ];
          volumes = [
            "/run/podman/podman.sock:/var/run/docker.sock"
            "portainer_data:/data"
          ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "Asia/Kolkata";
            DOCKER_HOST=tcp://dockerproxy:2375;
          };
          pull = "newer";
        };
      };
    };
  };
}
