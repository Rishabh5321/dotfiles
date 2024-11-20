{ config, pkgs, ... }:

{
  # Enable Flatpak support
  environment.systemPackages = with pkgs; [
    flatpak
  ];

  # Add Flatpak to your user's path
  users.users.rishabh.packages = with pkgs; [
    flatpak
  ];

  # Optionally, set up Flatpak permissions
  programs.flatpak.enable = true;

  # Add common Flatpak repositories
  systemd.services.flatpak-add-repo = {
    description = "Add Flathub repository";
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo";
      Type = "oneshot";
    };
  };
}
