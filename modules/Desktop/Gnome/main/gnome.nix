# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
{pkgs , ...}: {
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services = {
    # Browser integration
    gnome.gnome-browser-connector.enable = true;
  };

  environment.systemPackages =
  with pkgs; [
    gnome-tweaks
    dconf-editor
  ];
}
