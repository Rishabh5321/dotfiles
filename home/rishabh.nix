{ pkgs
, wallpapers
, wallpaper
, flakeDir
, lib
, config
, inputs
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

  home.file."Pictures/Wallpapers" = {
    source = wallpapers;
    recursive = true;
  };

  home.sessionVariables = {
    XDG_DATA_DIRS = lib.mkForce "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
    # QS_ICON_THEME = "Papirus-Dark";
  };

  stylix = {
    enable = true;
    image = "${wallpapers}/${wallpaper}";
    polarity = "dark";

    /*
      cursor = {
      package = pkgs.afterglow-cursors-recolored;
      name = "Afterglow-Recolored-Catppuccin-Flamingo";
      size = 24;
      };
    */

    fonts = {

      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };

      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };

      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    opacity = {
      applications = 1.0;
      popups = 1.0;
      terminal = 1.0;
      desktop = 1.0;
    };

    targets = {
      font-packages.enable = true;
      gtk.enable = false;
      waybar.enable = false;
      rofi.enable = false;
      wofi.enable = false;
      qt.enable = true;
      qt.platform = "qtct";
      hyprland.enable = false;
      swaylock.enable = false;
      hyprpanel.enable = false;
      # zed.enable = true;
      zen-browser.enable = false;
      # spicetify.enable = false;
    };
  };

  gtk = {
    enable = false;

    # iconTheme = {
    #   enable = true;
    #   package = pkgs.papirus-icon-theme;
    # };

    theme = {
      name = "adw-gtk3";
    };
  };

  targets.genericLinux.enable = true;

  # Set your username
  home.username = "rishabh";
  home.homeDirectory = "/home/rishabh";

  # Nicely reload system units
  systemd.user.startServices = "sd-switch";

  # Basic packages
  home.packages = with pkgs; [
    afterglow-cursors-recolored
    noto-fonts
    nerd-fonts.hack
    noto-fonts-color-emoji
    papirus-icon-theme
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
    librsvg
    libsForQt5.qtsvg
    shared-mime-info
    antigravity
    nwg-look
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.fladder
    # inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.zed-editor
  ];

  systemd.user.services.noctalia-shell = {
    Unit.After = [ "graphical-session.target" ];
    Service = {
      Environment = lib.mkForce [
        "PATH=$PATH:/usr/bin:/bin:/run/current-system/sw/bin:/etc/profiles/per-user/${config.home.username}/bin:${config.home.profileDirectory}/bin"
        # "XDG_DATA_DIRS=${config.home.homeDirectory}/.nix-profile/share:${config.home.homeDirectory}/.local/share:/usr/local/share:/usr/share"
        # "GDK_PIXBUF_MODULE_FILE=${pkgs.librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache"
        # "QT_PLUGIN_PATH=${pkgs.kdePackages.qtsvg}/lib/qt-6/plugins:${pkgs.libsForQt5.qtsvg}/lib/qt-5/plugins"
        # "XCURSOR_PATH=${config.home.homeDirectory}/.icons:${config.home.homeDirectory}/.local/share/icons:/usr/share/icons:/usr/share/pixmaps"

        # FORCE NOCTALIA TO USE PAPIRUS
        # "QS_ICON_THEME=Papirus-Dark"
      ];
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
        "https://cache.nixos.org?priority=10" # official

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

  home.activation = {
    syncWaylandSessions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      TARGET_DIR="/usr/share/wayland-sessions"
      NIX_SESSIONS_DIR="$HOME/.nix-profile/share/wayland-sessions"
      SUDO="/usr/bin/sudo"

      if [ -d "$NIX_SESSIONS_DIR" ]; then
          # 1. Ensure the system directory exists
          $SUDO mkdir -p "$TARGET_DIR"

          for session_file in "$NIX_SESSIONS_DIR"/*.desktop; do
              filename=$(basename "$session_file")
              wm_name=''${filename%.desktop} # Extracts 'sway' or 'hyprland'
              TEMP_FILE="/tmp/$filename"
              cp "$session_file" "$TEMP_FILE"

              # 2. Dynamically find the binary path in the Nix store
              BIN_NAME=$(grep -Po '^Exec=\K[^ ]+' "$session_file" | head -n 1)
              FULL_PATH=$(${pkgs.coreutils}/bin/readlink -f $(${pkgs.which}/bin/which "$BIN_NAME" 2>/dev/null) || echo "$BIN_NAME")

              # 3. Apply the Environment Wrapper
              # This works for any WM by sourcing your profile and setting the correct XDG variables
              sed -i "s|^Exec=.*|Exec=bash -c 'source /etc/profile; source \$HOME/.profile; export XDG_CURRENT_DESKTOP=$wm_name; export XDG_SESSION_DESKTOP=$wm_name; export WLR_NO_HARDWARE_CURSORS=1; exec $FULL_PATH'|" "$TEMP_FILE"

              echo "Syncing $filename with dynamic environment wrapper to GDM..."
              $SUDO cp "$TEMP_FILE" "$TARGET_DIR/$filename"
              $SUDO chmod 644 "$TARGET_DIR/$filename"
          done
      fi

      # 4. Cleanup orphaned links (optional but recommended)
      # Removes links in /usr/share/wayland-sessions that no longer exist in your Nix profile
      for link in "$TARGET_DIR"/*.desktop; do
          if [ -L "$link" ] || [ -f "$link" ]; then
              base=$(basename "$link")
              if [ ! -f "$NIX_SESSIONS_DIR/$base" ] && [[ "$(grep "Nix" "$link")" ]]; then
                   echo "Cleaning up old session: $base"
                   $SUDO rm "$link"
              fi
          fi
      done
    '';
  };
}
