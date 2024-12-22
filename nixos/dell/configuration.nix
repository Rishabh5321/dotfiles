# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos
    ./power.nix
    ../../modules/Desktop/Budgie/main
    ./intel-drivers.nix
    #./amd-drivers.nix
  ];

  drivers.intel.enable = true;
  #drivers.amdgpu.enable = false;
  #nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "dell"; # Define your hostname.
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

  #services.displayManager = {
  #  enable = true;
  #  sddm = {
  #    enable = true;
  #    wayland = {
  #      enable = true;
  #    };
  #    settings = {
  #      Autologin = {
  #        Session = "hyprland";
  #        User = "rishabh";
  #      };
  #    };
  #    autoNumlock = true;
  #  };
  #};
  #services.desktopManager.cosmic.enable = true;

  #services.displayManager.sddm.theme = "sddm-astronaut-theme";
  #services.desktopManager.plasma6.enable = true;
  #services.displayManager.sddm.enable = true;

  #services.xserver = {
  #  enable = true;
  #  desktopManager = {
  #    xterm.enable = false;
  #    xfce = {
  #      enable = true;
  #      #noDesktop = true;
  #      enableXfwm = false;
  #    };
  #  };
  #  xkb = {
  #    layout = "us";
  #    variant = "";
  #  };
  #  windowManager.i3.enable = true;
  #};
  #services.displayManager.defaultSession = "xfce";

  # Enable CUPS to print documents.
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
  # services.openssh.enable = true;

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
  system.stateVersion = "24.11"; # Did you read the comment?

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      #pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };

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

}
