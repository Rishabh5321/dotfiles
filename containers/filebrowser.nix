# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "docker";

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
        };
      };
    };
  };
}
