# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ inputs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/system
    ../common/power-server.nix
    ../../modules/desktop/Sway-Noctalia/main
    inputs.nixos-hardware.nixosModules.xiaomi-redmibook-15-pro-2021
  ];

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

  # Configure keymap in X11
  # Enable the KDE Plasma Desktop Environment.
  #services.desktopManager.plasma6.enable = true;
  #services.displayManager.sddm.enable = true;

  services = {
    xserver = {
      enable = true;
      #displayManager.gdm.enable = true;
      #desktopManager.gnome.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      #videoDrivers = [ "intel" ];
    };
    #displayManager.sddm.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # networking.firewall = {
  #   allowedTCPPorts = [ 53 80 5353 8080 ];
  #   allowedUDPPorts = [ 53 80 5353 8080 ];
  # };
  # networking.firewall.trustedInterfaces = [ "wlp0s20f3" "enp2s0" ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
