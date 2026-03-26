{ pkgs, inputs, ... }:
{
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
}
