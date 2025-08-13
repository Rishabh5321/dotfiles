{ config, pkgs, lib, ... }:

{
  programs.swaylock = {
    enable = config.wayland.windowManager.sway.enable;
    package = pkgs.swaylock-effects;
    settings = {
      font = "SauceCodePro Nerd Font";
      font-size = 32;

      screenshots = true;
      fade-in = 1;
      effect-pixelate = 8;
      grace = 5;
      clock = true;
      datestr = "%a, %d. %b %Y";
      indicator = true;
      indicator-radius = 120;
      inside-color = "1613207f";
      key-hl-color = "abe9b3";
      bs-hl-color = "e8a2af";
      ring-color = "abe9b37f";
      text-color = "abe9b3";

      inside-clear-color = "abe9b37f";
      ring-clear-color = "abe9b3";
      text-clear-color = "161320";

      inside-ver-color = "b5e8e07f";
      ring-ver-color = "b5e8e0";
      text-ver-color = "161320";

      inside-wrong-color = "e8a2af7f";
      ring-wrong-color = "e8a2af";
      text-wrong-color = "161320";

      line-color = "00000000";
      line-clear-color = "00000000";
      separator-color = "00000000";
    };
  };
}
