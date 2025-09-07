{ pkgs
, ...
}:
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      alsaSupport = true;
      githubSupport = true;
      mpdSupport = true;
      pulseSupport = true;
    };
    script = builtins.readFile ./launch.sh;
  };

  xdg.configFile."polybar" = {
    source = ./config;

    recursive = true;
  };
}
