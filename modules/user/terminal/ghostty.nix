{ inputs, pkgs, ... }:

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
        font-family = "PragmataPro Liga";
        font-thicken = true;
        # font-size = "16";
        # font-feature = "calt liga";

        # Cursor settings
        # cursor-style = "block";
        custom-shader = toString (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/KroneCorylus/ghostty-shader-playground/refs/heads/main/shaders/cursor_smear_fade.glsl";
          sha256 = "sha256-2XGq3qIGT7LGsHiFZbGmci/M8CkTGNBDHGImGkKnoCk=";
        });

        # Misc settings
        # macos-option-as-alt = true;
        # confirm-close-surface = false;
        term = "xterm-256color";
      };
    };
  };
}
