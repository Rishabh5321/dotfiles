# hosts/iso/configuration.nix - Alternative approach
{ config, pkgs, lib, inputs, username, ... }:
{
  imports = [
    # Use a different base that doesn't have wireless pre-configured
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
    # Or try this one:
    # "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix"
  ];

  # Set the state version for compatibility
  system.stateVersion = "24.11";

  # ISO-specific configuration
  isoImage.makeEfiBootable = true;
  isoImage.makeUsbBootable = true;
  isoImage.volumeID = "NIXOS_ISO";

  # Network configuration
  networking.hostName = "nixos-iso";
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;
  # Don't set wireless at all, let NetworkManager handle it

  # Essential services
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  # Packages for the ISO
  environment.systemPackages = with pkgs; [
    micro
    wget
    git
    neofetch
    htop
    pciutils
    usbutils
    curl
    firefox
    gparted
    # Add any other tools you need for installation
  ];

  # User configuration
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    password = ""; # No password for the live user
  };

  # Allow the user to use sudo without password
  security.sudo.wheelNeedsPassword = false;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Optional: Add your dotfiles to the ISO
  system.activationScripts.dotfiles = ''
    mkdir -p /home/${username}/dotfiles
    chown ${username}:users /home/${username}/dotfiles
  '';
}
