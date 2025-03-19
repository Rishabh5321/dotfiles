{ config, pkgs, username, ... }:

{
  # ISO-specific configurations

  # Enable networking with NetworkManager only
  networking = {
    networkmanager.enable = true;
  };

  # Enable SSH for remote assistance during installation
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  # Set up basic system configuration
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable MATE desktop environment (Optional, can be disabled if using TTY only)
  #services.xserver.enable = false; # Disable Xserver for now to ensure TTY works

  # Enable a display manager (If you want GUI later, set services.xserver.enable = true;)
  # services.xserver.displayManager.sddm.enable = true;

  # Enable TTY login prompt
  #systemd.defaultTarget = "multi-user.target";
  #services.getty.defaultUser = username;
  #services.getty.autoLogin = true;
  #systemd.services."getty@tty1".enable = true;

  # Ensure essential kernel modules are available
  boot.initrd.kernelModules = [ "i915" "amdgpu" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "systemd.log_level=debug" "systemd.log_target=console" ];

  # Enable GRUB for the ISO
  #boot.loader.grub.enable = true;
  #boot.loader.grub.device = "nodev";
  #boot.loader.grub.useOSProber = false;
  #boot.loader.timeout = 5;

  # Add the flake to the ISO
  system.activationScripts.dotfiles = ''
    mkdir -p /home/${username}/dotfiles
    cp -r ${../..}/* /home/${username}/dotfiles/
    chown -R ${username}:users /home/${username}/dotfiles
  '';

  # Essential installation tools
  environment.systemPackages = with pkgs; [
    gnome.gnome-terminal
    gnome.nautilus
    firefox-esr
    gparted
    parted
    git
    ntfs3g
    btrfs-progs
    e2fsprogs
    dosfstools
    pciutils
    usbutils
  ];

  # Enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Create installation helper script
  environment.etc."install-system.sh" = {
    text = ''
      #!/bin/sh
      echo "======================= NixOS Installation Helper ======================="
      echo "Your flake is available at /home/${username}/dotfiles"
      echo ""
      echo "Quick install commands:"
      echo "cd /home/${username}/dotfiles"
      echo "sudo nixos-install --flake .#redmi    # For Redmi laptop"
      echo "sudo nixos-install --flake .#dell     # For Dell laptop"
      echo "=================================================================="
    '';
    mode = "0755";
  };

  # Smaller README
  environment.etc."README.md" = {
    text = ''
      # NixOS Installation ISO
      
      Run /etc/install-system.sh for installation instructions.
    '';
    mode = "0644";
  };

  # Disable unnecessary services
  services.printing.enable = false;
  services.avahi.enable = false;

  # Minimize system size
  documentation.enable = false;
  documentation.nixos.enable = false;
  documentation.man.enable = false;
  documentation.info.enable = false;
  documentation.doc.enable = false;
}
