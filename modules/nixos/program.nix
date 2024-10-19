{ pkgs
, options
, lib
, ...
}: {
  programs = {
    firefox.enable = true;
    hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
    };
    dconf.enable = true;
    #seahorse.enable = lib.mkForce true;
    #fuse.userAllowOther = true;
    #mtr.enable = true;dconf
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    virt-manager.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    gamemode.enable = true;
  };

  # services.gnome.gnome-keyring = {
  #   enable = true;
  # };

  # services = {
  #   nfs.server.enable = true;
  # };

  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "prohibit-password";
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    storageDriver = "btrfs";
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
  ];
}
