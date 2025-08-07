_:
{
  programs.swaylock = {
    enable = true;
    settings = {
      # color = lib.removePrefix "#" config.stylix.base16Scheme.base00;
      font = "JetBrains Mono Nerd Font Mono";
      font-size = 24;
      indicator-radius = 200;
      indicator-thickness = 20;
      # line-color = lib.removePrefix "#" config.stylix.base16Scheme.base03;
      # key-hl-color = lib.removePrefix "#" config.stylix.base16Scheme.base0D;
      # ring-color = lib.removePrefix "#" config.stylix.base16Scheme.base0B;
      separator-color = "00000000"; # transparent
      # inside-color = lib.removePrefix "#" config.stylix.base16Scheme.base01;
      # text-color = lib.removePrefix "#" config.stylix.base16Scheme.base05;
      # text-caps-lock-color = lib.removePrefix "#" config.stylix.base16Scheme.base08;
      show-failed-attempts = true;
      show-indicator = true;
      # image = "${config.home.homeDirectory}/Pictures/Wallpapers/${config.stylix.image}";
    };
  };
}
