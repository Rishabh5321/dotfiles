# common/home-manager/eldios/programs/ghostty.nix
{ config, ... }:

{
  programs = {
    ghostty = {
      enable = true;

      # Ghostty settings
      settings = {
        # Window settings
        window-decoration = false;
        window-padding-x = 10;
        window-padding-y = 10;
        background-opacity = 0.95;

        # Font settings - will use system font from Stylix
        font-family = config.stylix.fonts.monospace.name;
        font-size = builtins.toString config.stylix.fonts.sizes.terminal;
        # font-feature = "calt liga";

        # Cursor settings
        cursor-style = "block";

        # Misc settings
        # macos-option-as-alt = true;
        confirm-close-surface = false;
      };
    };
  };
}
