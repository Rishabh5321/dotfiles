# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "docker";

      containers = {
        dockerproxy = {
          image = "ghcr.io/tecnativa/docker-socket-proxy:latest";
          autoStart = true;
          ports = [ "2375:2375" ];
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock:ro"
          ];
          environment = {
            CONTAINERS = "1"; # Allow access to viewing containers
            SERVICES = "1";
            TASKS = "1";
            POST = "0";
          };
        };
      };
    };
  };
}
