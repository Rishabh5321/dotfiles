# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
{pkgs, ...}: {
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services = {
    # Browser integration
    gnome.gnome-browser-connector.enable = true;

    # Trash folder in Gnome apps
    # gvfs.enable = true;

    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];
  };

  # System packages
  environment.systemPackages = with pkgs;
  with gnome;
  with gnomeExtensions; [
    # Essential
    gnome-tweaks
    gnome-settings-daemon

    # Extensions
    gsconnect # conflicts with kdeconnect, either one is fine or stop kdeconnect
    clipman
    user-avatar-in-quick-settings
    wayland-or-x11
    material-shell
    appindicator
    just-perfection
    uptime-indicator
    display-scale-switcher
    privacy-settings-menu
    blur-my-shell
  ];

  # Excluding unwanted packages
  environment.gnome.excludePackages = with pkgs.gnome; [
    gnome-system-monitor
    gnome-text-editor
    gnome-tour
    gnome-connections
    gnome-screenshot
    cheese
    epiphany
    yelp
    simple-scan
    gnome-weather
    gnome-contacts
    gnome-clocks
    gnome-maps
    gnome-calculator
  ];
}