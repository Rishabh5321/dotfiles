{ pkgs, inputs, ... }:
{
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
    mangohud
    nwg-look
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.anymex
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.fladder
    inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.playtorrio
    # inputs.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.zed-editor
  ];
}
