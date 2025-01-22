# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "docker";

      containers = {
        Casa = {
          image = "dockurr/casa:latest";
          autoStart = true;
          ports = [ "9341:8080" ];
          volumes = [
            "/home/rishabh/docker/casa:/DATA"
            "/var/run/docker.sock:/var/run/docker.sock"
          ];
        };
      };
    };
  };
}
