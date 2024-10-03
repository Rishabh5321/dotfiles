{ pkgs-unstable, ... }: {
  environment.systemPackages = with pkgs-unstable; [
    #jellyfin-media-player
    dconf-editor
    gnome-disk-utility
    gnome-system-monitor
    gnome-tweaks
    nautilus
    zed-editor
  ];
}
