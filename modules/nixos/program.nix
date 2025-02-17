{ pkgs
, options
, username
, ...
}: {
  programs = {
    firefox.enable = true;
    #hyprland = {
    #  enable = true;
    #  package = pkgs.hyprland;
    #  xwayland.enable = true;
    #};
    dconf.enable = true;
    #seahorse.enable = lib.mkForce true;
    #fuse.userAllowOther = true;
    #mtr.enable = true;dconf
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    virt-manager.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    gamemode.enable = true;
  };
  virtualisation.libvirtd.enable = true;
  users.groups.libvirtd.members = [ "${username}" ];
  virtualisation.spiceUSBRedirection.enable = true;
  services.gvfs.enable = true;

  services.gnome.gnome-keyring = {
    enable = true;
  };

  # services = {
  #   nfs.server.enable = true;
  # };

  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "prohibit-password";
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    podman = {
      enable = true;
    };
  };
  services.udisks2.enable = true;
  services.fstrim.enable = true;
  services.cloudflare-warp.enable = true;

  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;

}
