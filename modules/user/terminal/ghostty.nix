{ config, inputs, pkgs, ... }:

{
  programs = {
    ghostty = {
      enable = true;
      package = inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default;

      # Ghostty settings
      settings = {
        # Window settings
        window-decoration = false;
        window-padding-x = 10;
        window-padding-y = 10;
        background-opacity = 1.0;

        # Font settings - will use system font from Stylix
        font-family = config.stylix.fonts.monospace.name;
        font-size = builtins.toString config.stylix.fonts.sizes.terminal;
        # font-feature = "calt liga";

        # Cursor settings
        # cursor-style = "block";
        custom-shader = toString (pkgs.fetchurl {
          url = "https://gist.githubusercontent.com/reshen/991d19f9f8c8fedf64ff726f05f05f44/raw/513dfc739ac0ee285c5f0886d0ec7d70ed5e7261/cursor_smear_fade.glsl";
          sha256 = "sha256-fECoZKRQeSzEoDjQTaxB0b9HAb1li8F4Kqxfxs4FITs=";
        });

        # Misc settings
        # macos-option-as-alt = true;
        # confirm-close-surface = false;
        term = "xterm-256color";
      };
    };
  };
}
