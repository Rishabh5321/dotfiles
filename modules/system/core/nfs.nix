_:
{
  fileSystems = {
    "/mnt/nfs/docker" = {
      device = "192.168.1.100:/mnt/Docker";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=600"
      ];
    };

    "/mnt/nfs/e_disk" = {
      device = "192.168.1.100:/mnt/E_Disk";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=600"
      ];
    };

    "/mnt/nfs/raid" = {
      device = "192.168.1.100:/mnt/Raid";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=600"
      ];
    };

    "/mnt/nfs/home_server" = {
      device = "192.168.1.100:/home";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=600"
      ];
    };
  };
}
