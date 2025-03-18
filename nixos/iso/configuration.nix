# nixos/iso/configuration.nix
{ config, pkgs, username, ... }:

{
  # ISO-specific configurations
  
  # Enable networking - fix conflict between NetworkManager and wireless
  networking = {
    networkmanager.enable = true;
    # Disable default wireless configuration since we're using NetworkManager
    wireless.enable = false;
  };
  
  # Enable SSH for remote assistance during installation
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  
  # Set up basic system configuration
  time.timeZone = "Asia/Kolkata";  # Adjust to your timezone
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Configure console keymap
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  
  # Enable basic graphical environment
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  
  # Add the flake to the ISO so it can be easily accessed
  system.activationScripts = {
    dotfiles = ''
      mkdir -p /home/${username}/dotfiles
      cp -r ${../..}/* /home/${username}/dotfiles/
      chown -R ${username}:users /home/${username}/dotfiles
    '';
  };
  
  # Add helpful tools for installation
  environment.systemPackages = with pkgs; [
    firefox
    gnome-terminal
    nautilus
    gnome-system-monitor
    parted
    gnome-disk-utility
    gptfdisk
    ntfs3g
    cryptsetup
    btrfs-progs
    e2fsprogs
    dosfstools
    pciutils
    usbutils
    git
    neofetch
    vscode
  ];
  
  # # Configure stylix with your wallpaper
  # stylix = {
  #   enable = true;
  #   image = ../wallpapers/${config.wallpaper};
  #   base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  #   cursor = {
  #     package = pkgs.bibata-cursors;
  #     name = "Bibata-Modern-Classic";
  #   };
  # };
  
  # Enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  # Create installation helpers
  environment.etc."install-system.sh" = {
    text = ''
      #!/bin/sh
      echo "This script will help you install your NixOS system using your flake"
      echo "Your flake is available at /home/${username}/dotfiles"
      echo ""
      echo "Quick commands:"
      echo "- cd /home/${username}/dotfiles"
      echo "- sudo nixos-install --flake .#redmi"
      echo "- sudo nixos-install --flake .#dell"
    '';
    mode = "0755";
  };
  
  # Create a simple readme
  environment.etc."README.md" = {
    text = ''
      # NixOS Installation ISO
      
      This is a custom NixOS installation ISO with your configuration flake included.
      
      ## Installation Instructions
      
      1. Connect to the internet using NetworkManager (nm-connection-editor)
      2. Partition your disks using GParted or the command line tools
      3. Mount your partitions under /mnt
      4. Run the installation:
         ```
         sudo nixos-install --flake /home/${username}/dotfiles#your-hostname
         ```
      5. Reboot into your new system
      
      Your flake is available at `/home/${username}/dotfiles`
    '';
    mode = "0644";
  };
}