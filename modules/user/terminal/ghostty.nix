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

        # Cursor settings
        # cursor-style = "block";
        custom-shader = toString (
          pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/KroneCorylus/ghostty-shader-playground/refs/heads/main/public/shaders/cursor_smear_fade.glsl";
            sha256 = "sha256-ts+BFuBnft711/rupxtzgDJ9aNXeP3UOpb99viFv5/I=";
          }
        );

        # Misc settings
        # macos-option-as-alt = true;
        # confirm-close-surface = false;
        term = "xterm-256color";
      };
    };
  };
}
