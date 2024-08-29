{
  pkgs,
  options,
  ...
}: {
  programs = {
    firefox.enable = true;
    # hyprland = {
    #   enable = true;
    #   package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    #   xwayland.enable = true;
    # };
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
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    #hyprland = {
    #  enable = true;
    #  package = pkgs.hyprland;
    #  xwayland.enable = true;
    #};
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

  networking.timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = true;
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    storageDriver = "btrfs";
  };
}
