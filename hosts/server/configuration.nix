# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ inputs, pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #../../modules/system
    ../common/power-server.nix
    # ../common/serve.nix
    # ../common/tailscale-server.nix
    #./amd-drivers.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ../../modules/system/core

    ../../modules/system/virtualization

    ../../modules/system/theme

    ../../modules/system/packages/auto-upgrade.nix
    ../../modules/system/packages/nh.nix
    ../../modules/system/packages/nix_settings.nix

    ../../modules/system/hardware/graphics.nix

    ../../modules/system/application/program.nix

    ../../modules/system/security/users.nix

  ];

  networking.hostName = "server"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.

  services = {
    xserver = {
      enable = true;
      #displayManager.lightdm.enable = true;
      #desktopManager.xfce = {
      #  enable = true;
      #enableXfwm = false;
      #};
      #displayManager.gdm.enable = true;
      #desktopManager.gnome.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      #windowManager.i3.enable = true;
    };
    #displayManager.defaultSession = "hyprland";
  };

  # users.users.beszel = {
  #   isSystemUser = true;
  #   group = "beszel";
  #   description = "Beszel Agent service user";
  # };
  # users.groups.beszel = {};

  # systemd.services.beszel-agent = {
  #   description = "Beszel Agent Service";
  #   after = [ "network.target" ];
  #   wantedBy = [ "multi-user.target" ];

  #   serviceConfig = {
  #     Environment = [
  #       "PORT=45876"
  #       ''KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+5reoHczT8BitLVL5W79/v0CvNZX5K8JQ+HmWLYXue"''
  #       # "EXTRA_FILESYSTEMS=/mnt/rust,/rpool,/flash,/mnt/pve/local-ext4,/mnt/pve/nvme"
  #     ];
  #     ExecStart = "/run/current-system/sw/bin/beszel-agent";
  #     User = "beszel";
  #     Restart = "always";
  #     RestartSec = 5;
  #   };
  # };

  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  services.samba = {
    enable = true;
    settings = {
      "root" = {
        path = "/"; # Replace with the directory you want to share
        browseable = true; # Allow it to be seen in the network browser
        readOnly = false; # Enable write access
        validUsers = [ "rishabh" ]; # Use 'rishabh' as the username
      };
      "mnt" = {
        path = "/mnt"; # Replace with the directory you want to share
        browseable = true; # Allow it to be seen in the network browser
        readOnly = false; # Enable write access
        validUsers = [ "rishabh" ]; # Use 'rishabh' as the username
      };
      "home" = {
        path = "/home/rishabh"; # Replace with the directory you want to share
        browseable = true; # Allow it to be seen in the network browser
        readOnly = false; # Enable write access
        validUsers = [ "rishabh" ]; # Use 'rishabh' as the username
      };
    };
  };

  services.smartd.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
    vim
    git
    gh
    micro
    nano
    smartmontools
    geminicommit
    smartmontools
    # cloudflare-warp
  ];

  # services.cloudflare-warp.enable = true;

}
