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

    # kodi

    # ===== OFFICE & PRODUCTIVITY =====
    # libreoffice # Office suite
    onlyoffice-desktopeditors # Alternative office suite

    # --- Fonts ---
    dejavu_fonts
    fira-code
    fira-code-symbols
    font-awesome
    hackgen-nf-font
    ibm-plex
    inter
    jetbrains-mono
    material-icons
    maple-mono.NF
    minecraftia
    nerd-fonts.im-writing
    nerd-fonts.blex-mono
    nerd-fonts.iosevka-term
    nerd-fonts.lilex
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-mono
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-monochrome-emoji
    powerline-fonts
    roboto
    roboto-mono
    symbola
    terminus_font

    # --- Browser ---
    brave

    # --- Communication & Productivity ---
    ayugram-desktop
    discord
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
    # antigravity
    nil
    nixd
    nixpkgs-fmt
    gemini-cli-bin
    geminicommit

    # --- System Utilities & Wayland ---
    duf
    fastfetch
    xdg-utils
    brightnessctl
    wl-clipboard
    shared-mime-info
    mangohud
    wgcf

    # --- Screenshots & Graphics ---
    gsettings-desktop-schemas
    grim
    slurp
    swappy
    librsvg
    kdePackages.qtsvg
    libsForQt5.qtsvg

    # --- Media Player ---
    delfin
    jellyfin-media-player
    vlc
    pear-desktop

    # ===== QT THEMING =====
    kdePackages.qtstyleplugin-kvantum # Qt5/6 Kvantum plugin
    libsForQt5.qtstyleplugin-kvantum # Qt5 Kvantum plugin
    libsForQt5.qt5.qtbase # Qt5 base
    libsForQt5.qt5.qtsvg # Qt5 SVG support

    # --- Custom / Flake Inputs ---
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.antigravity
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.ab-download-manager
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.anymex
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.better-control
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.fladder
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.helium
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.hydralauncher
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.mangayomi
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.playtorrio
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.shonenx
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.skystream
    # inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.stremio
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.sorayomi
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.surge
  ];
}
