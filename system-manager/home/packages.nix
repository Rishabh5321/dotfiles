{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # --- Desktop & UI Customization ---
    nwg-look
    afterglow-cursors-recolored
    papirus-icon-theme
    adwaita-icon-theme
    hicolor-icon-theme
    dracula-icon-theme # Dracula icons
    qogir-icon-theme # Qogir icons
    # tela-icon-theme # Tela icons

    # --- GTK Themes ---
    orchis-theme
    material-black-colors
    nordic

    # --- File Managers ---
    thunar
    nemo
    # nautilus

    # ===== OFFICE & PRODUCTIVITY =====
    libreoffice # Office suite
    onlyoffice-desktopeditors # Alternative office suite

    # --- Fonts ---
    nerd-fonts.hack
    noto-fonts # Google Noto fonts
    noto-fonts-color-emoji # Emoji support
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

    # --- Communication & Productivity ---
    ayugram-desktop
    # discord
    obsidian
    kdePackages.kdeconnect-kde

    # --- Games ---
    aisleriot # Card Game
    pysolfc # Solitaire Game
    gamescope # Gaming compositor
    heroic
    protonplus
    protonup-qt
    steam
    umu-launcher

    # --- Development & Nix Tooling ---
    antigravity
    nil
    nixd
    nixpkgs-fmt
    gemini-cli-bin
    geminicommit

    # --- System Utilities & Wayland ---
    fastfetch
    xdg-utils
    brightnessctl
    wl-clipboard
    shared-mime-info
    mangohud
    wgcf

    # --- Screenshots & Graphics ---
    grim
    slurp
    swappy
    librsvg
    kdePackages.qtsvg
    libsForQt5.qtsvg

    # --- Media Player ---
    jellyfin-media-player
    vlc
    pear-desktop

    # ===== QT THEMING =====
    kdePackages.qtstyleplugin-kvantum # Qt5/6 Kvantum plugin
    libsForQt5.qtstyleplugin-kvantum # Qt5 Kvantum plugin
    libsForQt5.qt5.qtbase # Qt5 base
    libsForQt5.qt5.qtsvg # Qt5 SVG support

    # --- Custom / Flake Inputs ---
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.anymex
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.fladder
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.playtorrio
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.ab-download-manager
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.better-control
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.shonenx
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.surge
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.zed-editor
  ];
}
