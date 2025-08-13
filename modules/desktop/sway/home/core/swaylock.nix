{ pkgs
, ...
}:
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock;
  };
}
