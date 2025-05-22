{ pkgs
, options
, ...
}: {
  programs = {
    firefox.enable = true;
    dconf.enable = true;
    nix-ld.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
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

  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "prohibit-password";
    };
    gnome.gnome-keyring = {
      enable = true;
    };
    udisks2.enable = true;
    fstrim.enable = true;
    cloudflare-warp.enable = true;
    libinput.enable = true;
    gvfs.enable = true;
    upower.enable = true;
  };
}
