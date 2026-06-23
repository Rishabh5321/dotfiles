{ pkgs
, lib
, ...
}: {
  programs = {
    # ===== DESKTOP APPLICATIONS =====
    firefox.enable = true;
    kdeconnect = {
      enable = true;
      package = lib.mkForce pkgs.kdePackages.kdeconnect-kde;
    };

    thunar = {
      enable = true;
      plugins = with pkgs; [
        xfce4-exo
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
        tumbler
      ];
    };

    # ===== SYSTEM UTILITIES =====
    dconf.enable = true;
    nix-ld.enable = true;
    mtr.enable = true;

    fuse.userAllowOther = true;

    # ===== SECURITY & AUTHENTICATION =====
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Keyring management (disabled)
    # seahorse.enable = lib.mkForce true;

    # ===== VIRTUALIZATION =====
    virt-manager.enable = false;

    # ===== GAMING =====
    gamemode.enable = true;
    gamescope.enable = true;
  };
}
