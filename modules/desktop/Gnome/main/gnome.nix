# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
{ pkgs, lib, ... }: {
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services = {
    # Browser integration
    gnome.gnome-browser-connector.enable = true;
  };

  programs.seahorse.enable = lib.mkForce true;

  environment.systemPackages =
    with pkgs; [
      gnome-tweaks
      dconf-editor
    ];

  environment.gnome.excludePackages = [
    pkgs.gnome-text-editor
  ];
}
