_: {
  services = {
    # ===== NETWORK & CONNECTIVITY =====
    # SSH daemon for remote access
    openssh = {
      enable = true;
      settings.PermitRootLogin = "prohibit-password"; # Security: disable root password login
    };

    # Cloudflare WARP VPN client
    # cloudflare-warp.enable = true;

    # ===== STORAGE & FILESYSTEM =====
    # Automatic disk management and mounting
    udisks2.enable = true;

    # SSD optimization - periodic TRIM for better performance
    fstrim.enable = true;

    # Virtual filesystem support for file managers
    gvfs.enable = true;

    davfs2.enable = true;

    # ===== INPUT & HARDWARE =====
    # Touchpad and input device configuration
    libinput.enable = true;

    # Power management for laptops/battery devices
    upower.enable = true;

    # ===== SECURITY & AUTHENTICATION =====
    # GNOME keyring for password/credential management
    gnome.gnome-keyring = {
      enable = true;
    };
  };
}
