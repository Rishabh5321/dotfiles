# <https://github.com/dockur/casa>
_: {
  virtualisation = {
    oci-containers = {
      backend = "docker";

      containers = {
        duplicati = {
          image = "lscr.io/linuxserver/duplicati:latest";
          autoStart = true;
          ports = [ "8200:8200" ];
          volumes = [
            "/mnt/Docker/Docker/Duplicati_Config:/config"
            "/mnt/Raid/Backup/:/backups"
            "/mnt/Docker/:/source"
            "/mnt/:/data"
            "/home/rishabh/:/source_home"
          ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "Asia/Kolkata";
            SETTINGS_ENCRYPTION_KEY = "Pass12345"; #STARTER PASSWORD CHANGED AFTER DEPLOYING CHECK 1
            DUPLICATI__WEBSERVICE_PASSWORD = "Pass12345"; #STARTER PASSWORD CHANGED AFTER DEPLOYING CHECK 1
          };
        };
      };
    };
  };
}
