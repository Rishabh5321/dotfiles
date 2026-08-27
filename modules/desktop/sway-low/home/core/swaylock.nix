{ pkgs, ... }:
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      font = "JetBrainsMono Nerd Font";
      font-size = 24;
      screenshots = true;
      fade-in = 1;
      effect-pixelate = 6;
      grace = 3;
      clock = true;
      datestr = "%a, %d %b %Y";
      indicator = true;
      indicator-radius = 80;
      inside-color = "1e1e2ef0";
      key-hl-color = "89b4fa";
      bs-hl-color = "f38ba8";
      ring-color = "313244";
      text-color = "cdd6f4";
      inside-clear-color = "1e1e2ef0";
      ring-clear-color = "89b4fa";
      text-clear-color = "cdd6f4";
      inside-ver-color = "1e1e2ef0";
      ring-ver-color = "f9e2af";
      text-ver-color = "cdd6f4";
      inside-wrong-color = "1e1e2ef0";
      ring-wrong-color = "f38ba8";
      text-wrong-color = "cdd6f4";
    };
  };
}
