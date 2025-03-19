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

  # Ensure essential kernel modules are available
  boot.initrd.kernelModules = [ "i915" "amdgpu" "radeon" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "systemd.log_level=debug" "systemd.log_target=console" "nomodeset" ];
  hardware.enableAllFirmware = true;

  # Add graphics support and essential installation tools
  environment.systemPackages = with pkgs; [
    mesa
    libva
    libvdpau-va-gl
    vulkan-tools
    glxinfo
    libva-utils
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

  # Add the flake to the ISO
  system.activationScripts.dotfiles = ''
    mkdir -p /home/${username}/dotfiles
    cp -r ${../..}/* /home/${username}/dotfiles/
    chown -R ${username}:users /home/${username}/dotfiles
  '';

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