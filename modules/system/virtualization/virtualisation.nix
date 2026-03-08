{ pkgs, username, ... }:
{
  users.users.${username}.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    adwaita-icon-theme
    libguestfs # Useful for accessing VM disks from the host
    bridge-utils # For managing virtual networks
  ];

  virtualisation = {
    libvirtd = {
      enable = false;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = false;
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    podman.enable = true;
  };

  security.polkit.enable = true;

  services.spice-vdagentd.enable = true;

  systemd.tmpfiles.rules = [
    "d /var/lib/libvirt/images 0770 root libvirtd -"
  ];

  environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
}
