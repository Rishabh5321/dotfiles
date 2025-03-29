# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "podman";

      containers = {
        flaresolverr = {
          image = "ghcr.io/flaresolverr/flaresolverr:latest";
          autoStart = true;
          ports = [ "8191:8191" ];
          environment = {
            TZ = "Asia/Kolkata";
          };
          pull = "newer";
        };
      };
    };
  };
}
