{ pkgs
, inputs
, ...
}: {

  # ===== SYSTEM PACKAGES =====
  environment.systemPackages =
    let
      stremio = pkgs.callPackage ../../../pkgs/stremio-linux-shell.nix { };
    in
    with pkgs; [

      # ===== Custom Packages =====
      stremio

      # ===== NUR =====
      nur.repos.colorman.speed-cloudflare-cli
      # nur.repos.charmbracelet.crush

      # ===== DEVELOPMENT TOOLS =====
      act # GitHub Actions local runner
      android-tools # ADB and fastboot
      cachix # Binary cache management
      docker # Container runtime
      docker-compose # Multi-container orchestration
      git # Version control
      gh # GitHub CLI
      github-desktop # GitHub GUI client
      # gitnuro # Git GUI client
      nil # Nix LSP server
      nixd # Nix language server
      nixpkgs-fmt # Nix code formatter
      nixpkgs-review # Nixpkgs PR review tool
      nix-prefetch # Nix package prefetcher
      nix-prefetch-github # Fetch GitHub repos for Nix
      nix-update # Nix package update tool
      nh # Nix helper
      openssl # Cryptography toolkit
      geminicommit # Gemini commit message generator
      zed-editor # Editor
      # nix-fast-build # Building flakes
      gemini-cli-bin # AI
      lazygit # Git TUI client
      lazydocker # Docker container management

      # ===== EDITORS & IDEs =====
      # android-studio # Android IDE
      code-cursor # AI-powered VS Code fork
      micro # Simple terminal editor
      kiro # AI-powered text editor
      obsidian # Knowledge management
      vim # Classic text editor
      vscode # VS Code editor

      # ===== TERMINAL APPLICATIONS =====
      alacritty # GPU-accelerated terminal
      atuin # Shell history with sync
      bat # Enhanced cat with syntax highlighting
      bottom
      btop # Resource monitor
      eza # Modern ls replacement
      fastfetch # System information tool
      fzf # Fuzzy finder
      # ghostty # Terminal emulator
      # gnome-console # GNOME terminal
      htop # Process monitor
      jq # JSON processor
      ranger # File manager
      tealdeer # Simplified man pages
      tree # Directory tree viewer
      # typer # Interactive typing test
      # toipe # Terminal typing test
      zsh # Advanced shell

      # ===== WEB BROWSERS =====
      brave # Privacy-focused browser
      firefox # Mozilla Firefox
      google-chrome # Google Chrome
      librewolf # Privacy-hardened Firefox

      # ===== COMMUNICATION & SOCIAL =====
      beeper # Universal chat client
      discord # Gaming communication
      # ferdium # Multi-service messaging
      telegram-desktop # Telegram client
      thunderbird-latest # Email client

      # ===== MEDIA & ENTERTAINMENT =====
      # jellyfin-media-player # Media center client
      # mangayomi # Manga reader
      # miru # Video streaming client
      delfin #jellyfin media player
      mpv-unwrapped # Video player
      kodi-wayland # Media center client
      spotify # Music streaming
      # stremio # Media streaming
      vlc # Multimedia player
      youtube-music # YouTube Music client
      qimgv #image viewer
      yazi # File manager

      # ===== GAMING =====
      gamescope # Gaming compositor
      heroic # Epic Games launcher
      lutris # Gaming platform manager
      mangohud # Gaming overlay
      steam # Steam gaming platform

      # ===== FILE MANAGEMENT =====
      file-roller # Archive manager
      filezilla # FTP client
      # kdePackages.dolphin # KDE file manager
      nautilus # GNOME file manager
      qbittorrent # BitTorrent client
      unrar # RAR extraction
      unzip # ZIP extraction

      # ===== SYSTEM UTILITIES =====
      cliphist # Clipboard manager
      cloudflare-warp # VPN client
      distrobox_git # Container-based environments
      fast-cli # Internet speed test
      gnome-disk-utility # Disk management
      gnome-keyring # Credential management
      gnome-system-monitor # System monitoring
      grim # Screenshot tool
      mesa # Graphics drivers
      mission-center # System information
      networkmanagerapplet # Network management
      nload # Network monitoring
      nwg-look # GTK theme manager
      podman-desktop # Container management GUI
      podman-tui # Container management TUI
      resources # System monitor
      rquickshare # File sharing
      samba # SMB/CIFS support
      slurp # Screen area selection
      speedtest-cli # Network speed test
      swappy # Screenshot annotation
      swww # Wallpaper manager
      tailscale # VPN mesh network
      virt-viewer # Virtual machine viewer
      vulkan-tools # Vulkan utilities
      wgcf # Cloudflare WARP config
      wget # File downloader
      winetricks # Windows compatibility
      wl-clipboard # Wayland clipboard
      dig # DNS lookup

      # ===== OFFICE & PRODUCTIVITY =====
      libreoffice # Office suite
      onlyoffice-bin_latest # Alternative office suite
      varia # Download Manager

      # ===== THEMES & ICONS =====
      dracula-icon-theme # Dracula icons
      papirus-icon-theme # Papirus icons
      qogir-icon-theme # Qogir icons
      tela-icon-theme # Tela icons

      # ===== QT THEMING =====
      kdePackages.qtstyleplugin-kvantum # Qt5/6 Kvantum plugin
      libsForQt5.qtstyleplugin-kvantum # Qt5 Kvantum plugin
      libsForQt5.qt5.qtbase # Qt5 base
      libsForQt5.qt5.qtsvg # Qt5 SVG support

      # ===== IMAGE PROCESSING =====
      # imagemagick # Image prossessing for wallsite project

      # ===== TEXT EDITORS (COMMENTED) =====
      #helix                 # Modern text editor

      # ===== DEVELOPMENT TOOLS (COMMENTED) =====
      #apkeep                # APK downloader
      #clinfo                # OpenCL info
      #flatpak-builder       # Flatpak development
      #nix-serve             # Nix binary cache server
      #tmux                  # Terminal multiplexer

      # ===== MEDIA TOOLS (COMMENTED) =====
      #spotdl                # Spotify downloader
      #revanced-cli          # YouTube Vanced patcher

      # ===== APPLICATIONS (COMMENTED) =====
      #deja-dup              # Backup tool
      grayjay # Video platform client
      #pods                  # Podcast client
      #popcorntime           # Movie streaming
      #protonup-qt           # Proton version manager
      #resilio-sync          # File synchronization
      #vivaldi               # Vivaldi browser
      #vivaldi-ffmpeg-codecs # Vivaldi media codecs

      # ===== CUSTOM PACKAGES (COMMENTED) =====
      #luminance             # Custom lighting tool

      # ===== FLAKE INPUTS =====
      # inputs.grayjay.packages.${pkgs.system}.grayjay # Video platform client
      # inputs.gemini-cli.packages.${pkgs.system}.gemini-cli-stable # stable versions
      inputs.better-control.packages.${pkgs.system}.better-control # Device control
      # inputs.zen-browser.packages."${system}".default # zen
      # inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default

      # ===== FLAKE INPUTS (COMMENTED) =====
      # inputs.akuse-flake.packages.${system}.akuse                 # Custom package
      # inputs.alejandra.defaultPackage.${system}                   # Nix formatter
      # inputs.thorium.packages."x86_64-linux".thorium-avx2         # Thorium browser
    ];

  # ===== FONTS CONFIGURATION =====
  fonts = {
    packages = with pkgs; [
      # ===== SYSTEM FONTS =====
      noto-fonts # Google Noto fonts
      noto-fonts-emoji # Emoji support
      noto-fonts-cjk-sans # CJK language support
      font-awesome # Icon font
      # symbola # Unicode symbols
      powerline # Powerline symbols

      # ===== PROGRAMMING FONTS =====
      fira-code # Ligature programming font
      fira-code-symbols # Fira Code symbols

      # ===== ICON FONTS =====
      material-icons # Material Design icons
      material-symbols # Material Symbols icons

      # ===== NERD FONTS =====
      nerd-fonts.ubuntu-sans # Ubuntu Sans with icons
      nerd-fonts.ubuntu-mono # Ubuntu Mono with icons
      nerd-fonts.ubuntu # Ubuntu with icons
      nerd-fonts.roboto-mono # Roboto Mono with icons
      nerd-fonts.profont # ProFont with icons
      nerd-fonts.noto # Noto with icons
      nerd-fonts.monaspace # Monaspace with icons
      nerd-fonts.meslo-lg # Meslo LG with icons
      nerd-fonts.jetbrains-mono # JetBrains Mono with icons
      nerd-fonts.caskaydia-cove
      nerd-fonts.meslo-lg
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only

      roboto
      (google-fonts.override { fonts = [ "Inter" ]; })

      # Monospace
      jetbrains-mono
    ];
  };
}
