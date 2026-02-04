{ pkgs
, wallpapers
, wallpaper
, inputs
, flakeDir
, lib
, config
, ...
}:

{
  imports = [
    # ./../modules/user/development/git.nix
    ./../modules/desktop/Sway-Noctalia/home

    ./../modules/user/development/lazygit.nix
    ./../modules/user/files
    ./../modules/user/monitor
    ./../modules/user/shells
    ./../modules/user/shells/oh-my-posh.nix
    ./../modules/user/terminal
    ./../modules/user/utilities/atuin.nix
    ./../modules/user/utilities/tealdeer.nix
    ./../modules/user/utilities/zoxide.nix
  ];

  home.shellAliases = {
    hms = "home-manager switch --flake ${flakeDir} -b bak";
  };

  stylix = {
    enable = false;
    image = "${wallpapers}/${wallpaper}";
    polarity = "dark";
  };

  targets.genericLinux.enable = true;

  # Set your username
  home.username = "rishabh";
  home.homeDirectory = "/home/rishabh";

  # Nicely reload system units
  systemd.user.startServices = "sd-switch";

  # Basic packages
  home.packages = with pkgs; [
    fastfetch
    obsidian
    discord
    geminicommit
    nil
    nixd
    nixpkgs-fmt
    gemini-cli
    xdg-utils
    brightnessctl
    slurp
    grim
    swappy
    kdePackages.qtsvg
    adwaita-icon-theme
    hicolor-icon-theme
    wl-clipboard
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.zed-editor
  ];

  systemd.user.services.noctalia-shell = {
    Service = {
      Environment = lib.mkForce (
        "PATH=$PATH:/usr/bin:/bin:/run/current-system/sw/bin:/etc/profiles/per-user/${config.home.username}/bin:${config.home.profileDirectory}/bin " +
        "XDG_DATA_DIRS=$XDG_DATA_DIRS:/home/${config.home.username}/.nix-profile/share:/home/${config.home.username}/.local/share:/usr/local/share:/usr/share " +
        "QT_PLUGIN_PATH=${pkgs.kdePackages.qtsvg}/lib/qt-6/plugins:${pkgs.qt6.qtbase}/lib/qt-6/plugins " +
        "QT_QPA_PLATFORMTHEME=kde " +
        "XCURSOR_PATH=~/.icons:~/.local/share/icons:/usr/share/icons:/usr/share/pixmaps"
      );
    };
  };

  # Set the state version
  home.stateVersion = "26.05";

  nix = {
    package = pkgs.nix;
    settings = {
      # ===== BINARY CACHE CONFIGURATION =====
      # Primary and community binary caches for faster builds
      substituters = [
        "https://cache.nixos.org?priority=10" #official

        "https://rishabh5321.cachix.org" # Personal cache
        "https://nixpkgs-wayland.cachix.org" # Wayland packages
        "https://cosmic.cachix.org/" # COSMIC desktop environment
        "https://nix-config.cachix.org" # Community configurations
        "https://nix-community.cachix.org" # Nix community packages
      ];

      # Public keys for verifying cache authenticity
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

        "rishabh5321.cachix.org-1:mxfBIH2XElE6ieFXXYBA9Ame4mVTbAf1TGR843siggk="
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

      # ===== EXPERIMENTAL FEATURES =====
      # Enable modern Nix features
      experimental-features = [
        "nix-command" # New nix CLI interface
        "flakes" # Flake system for reproducible configurations
      ];
    };

    # ===== GARBAGE COLLECTION (DISABLED) =====
    # Automatic cleanup handled by nh instead
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 3d";
    # };
  };
}
