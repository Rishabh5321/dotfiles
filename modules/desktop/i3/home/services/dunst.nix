{ config, lib, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = lib.mkForce "JetBrainsMono Nerd Font Mono 10";
        format = ''
          <b>%s</b>
          %b
        '';
        sort = "yes";
        indicate_hidden = "yes";
        alignment = "left";
        bounce_freq = 0;
        show_age_threshold = 60;
        word_wrap = "yes";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = true;
        show_indicators = "yes";
        icon_position = "left";
        max_icon_size = 32;
        frame_color = "#${config.stylix.base16Scheme.base0D}";
        separator_color = lib.mkForce "#${config.stylix.base16Scheme.base0D}";
        padding = 8;
        horizontal_padding = 8;
        transparency = 10;
        corner_radius = 15;
      };
    };
  };
}
