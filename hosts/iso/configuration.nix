{ pkgs, lib, ... }:

{
  imports = [
    ../../modules/system/core
    ../../modules/system/network
    ../../modules/system/security/users.nix
  ];

  # Set the state version for compatibility
  system.stateVersion = "24.11";

  # Configure the bootloader
  boot.loader.grub.enable = lib.mkForce false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # Specify the root filesystem
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_ISO";
    fsType = "iso9660";
  };

  # Minimal set of packages for a bootable ISO
  environment.systemPackages = with pkgs; [
    micro
    wget
    git
    neofetch
    htop
    pciutils
    usbutils
  ];

  # Add a default user
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # For sudo access
    password = ""; # No password for the live user
  };

  # Enable the OpenSSH server
  services.openssh.enable = true;
}
