# hosts/iso/configuration.nix - Alternative approach
{ pkgs, inputs, username, lib, ... }:
{
  imports = [
    # Use a different base that doesn't have wireless pre-configured
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
    # Or try this one:
    # "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix"
  ];

  # Set the state version for compatibility
  system.stateVersion = "26.05";

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
    tparted
    nh
    gparted
    # Add any other tools you need for installation
  ];

  users.mutableUsers = true;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialHashedPassword = lib.mkForce null;
    initialPassword = "nixos"; # Default password for live user
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

  nix = {
    settings = {
      substituters = [
        "https://rishabh5321.cachix.org" # Personal cache
        "https://cache.nixos.org" # Official NixOS cache
        "https://nixpkgs-wayland.cachix.org" # Wayland packages
        "https://cosmic.cachix.org/" # COSMIC desktop environment
        "https://nix-config.cachix.org" # Community configurations
        "https://nix-community.cachix.org" # Nix community packages
      ];

      trusted-substituters = [
        "https://rishabh5321.cachix.org"
        "https://cache.nixos.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://cosmic.cachix.org/"
        "https://nix-config.cachix.org"
        "https://nix-community.cachix.org"
      ];

      # Public keys for verifying cache authenticity
      trusted-public-keys = [
        "rishabh5321.cachix.org-1:mxfBIH2XElE6ieFXXYBA9Ame4mVTbAf1TGR843siggk="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        "nix-config.cachix.org-1:Vd6raEuldeIZpttVQfrUbLvXJHzzzkS0pezXCVVjDG4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];


      # ===== PERFORMANCE OPTIMIZATIONS =====
      # Automatically optimize store by hard-linking identical files
      auto-optimise-store = true;

      # Large download buffer for better network performance (500 MB)
      download-buffer-size = 500000000;
    };
  };
}
