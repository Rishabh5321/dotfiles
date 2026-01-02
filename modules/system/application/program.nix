{ pkgs
, ...
}: {
  programs = {
    # ===== DESKTOP APPLICATIONS =====
    firefox.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
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
    #seahorse.enable = lib.mkForce true;

    # ===== VIRTUALIZATION =====
    virt-manager.enable = true;

    # ===== GAMING =====
    gamemode.enable = true;
    gamescope.enable = true;
  };
}
