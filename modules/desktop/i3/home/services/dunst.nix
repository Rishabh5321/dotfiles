{ config, lib, ... }:

let
  stylixEnabled = if config ? stylix then config.stylix.enable else false;
  palette = if stylixEnabled then config.lib.stylix.colors else {
    base00 = "000000"; base01 = "1e1e2e"; base02 = "313244"; base03 = "45475a";
    base04 = "585b70"; base05 = "cdd6f4"; base06 = "f5e0dc"; base07 = "b4befe";
    base08 = "f38ba8"; base09 = "fab387"; base0A = "f9e2af"; base0B = "a6e3a1";
    base0C = "94e2d5"; base0D = "89b4fa"; base0E = "cba6f7"; base0F = "f2cdcd";
  };
in
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
        stack_duplicates = true;
        hide_duplicate_count = true;
        show_indicators = "yes";
        icon_position = "left";
        max_icon_size = 32;
        frame_color = lib.mkIf stylixEnabled "#${palette.base0D}";
        separator_color = lib.mkForce (if stylixEnabled then "#${palette.base0D}" else "#ffffff");
        padding = 8;
        horizontal_padding = 8;
        transparency = 10;
        corner_radius = 15;
      };

      urgency_low = {
        background = lib.mkForce "#${palette.base00}";
        foreground = lib.mkForce "#${palette.base05}";
        timeout = 10;
      };

      urgency_normal = {
        background = lib.mkForce "#${palette.base00}";
        foreground = lib.mkForce "#${palette.base05}";
        timeout = 10;
      };

      urgency_critical = {
        background = lib.mkForce "#${palette.base00}";
        foreground = lib.mkForce "#${palette.base08}";
        frame_color = lib.mkForce "#${palette.base08}";
        timeout = 0;
      };
    };
  };
}
