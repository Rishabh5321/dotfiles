_: {
  virtualisation = {
    oci-containers = {
      backend = "podman";

      containers = {
        filebrowser = {
          image = "hurlenko/filebrowser";
          autoStart = true;
          user = "1000";
          ports = [ "700:8080" ];
          volumes = [
            "/:/data"
            "/mnt/Docker/Docker/FileBrowser_Config:/config"
          ];
          environment = {
            FB_BASEURL = "/filebrowser";
          };
          pull = "newer";
        };
      };
    };
  };
}
