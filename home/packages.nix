{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # --- Desktop & UI Customization ---
    nwg-look
    afterglow-cursors-recolored
    papirus-icon-theme
    adwaita-icon-theme
    hicolor-icon-theme

    # --- GTK Themes ---
    orchis-theme
    material-black-colors
    nordic

    # --- Fonts ---
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.hack

    # --- Communication & Productivity ---
    ayugram-desktop
    discord
    obsidian

    # --- Development & Nix Tooling ---
    antigravity
    nil
    nixd
    nixpkgs-fmt
    gemini-cli
    geminicommit

    # --- System Utilities & Wayland ---
    fastfetch
    xdg-utils
    brightnessctl
    wl-clipboard
    shared-mime-info
    mangohud

    # --- Screenshots & Graphics ---
    grim
    slurp
    swappy
    librsvg
    kdePackages.qtsvg
    libsForQt5.qtsvg

    # --- Custom / Flake Inputs ---
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.anymex
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.fladder
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.playtorrio
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.ab-download-manager
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.better-control
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.playtorrio
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.surge
    # inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.zed-editor
  ];
}
