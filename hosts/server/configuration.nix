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

    # ../../modules/system/virtualization/default.nix

  ];

  networking = {
    # 1. Attach the physical port to the bridge
    bridges."br0".interfaces = [ "enp2s0" ];

    # 2. Tell the Firewall to stop blocking traffic on these interfaces
    firewall.trustedInterfaces = [ "br0" "virbr0" ];

    # 3. Ensure the bridge gets the host's IP, not the physical port
    interfaces."br0".useDHCP = true;
    interfaces."enp2s0".useDHCP = false;
  };

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /mnt   *(rw,sync,no_subtree_check,fsid=1)
    /home  *(rw,sync,no_subtree_check,fsid=2)
  '';

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
  system.stateVersion = "26.05"; # Did you read the comment?

  services.samba = {
    enable = true;
    # The global section ensures Samba allows guests
    settings = {
      global = {
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };

      "root" = {
        path = "/";
        browseable = true;
        readOnly = false;
        validUsers = [ "rishabh" ];
      };

      "mnt" = {
        path = "/mnt";
        browseable = true;
        readOnly = false;
        validUsers = [ "rishabh" ];
      };

      "home" = {
        path = "/home/rishabh";
        browseable = true;
        readOnly = false;
        validUsers = [ "rishabh" ];
      };

      # Public Share 1
      "gostream-mkv-virtual" = {
        path = "/mnt/gostream-mkv-virtual";
        browseable = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "public" = "yes";
        oplocks = "no";
        "aio read size" = "1";
        deadtime = "15";
        "vfs objects" = "fileid";
      };

      # Public Share 2
      "gostream-mkv-real" = {
        path = "/mnt/gostream-mkv-real";
        browseable = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "public" = "yes";
        oplocks = "no";
        "aio read size" = "1";
        deadtime = "15";
        "vfs objects" = "fileid";
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
    distrobox
    # cloudflare-warp
  ];

  # services.cloudflare-warp.enable = true;

}
