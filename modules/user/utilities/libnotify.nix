{ config
, pkgs
, lib
, ...
}:

let
  inherit (lib) mkForce;
  stylixEnabled = if config ? stylix then config.stylix.enable else false;
  palette = if stylixEnabled then config.stylix.base16Scheme else {
    base00 = "000000"; base01 = "1e1e2e"; base02 = "313244"; base03 = "45475a";
    base04 = "585b70"; base05 = "cdd6f4"; base06 = "f5e0dc"; base07 = "b4befe";
    base08 = "f38ba8"; base09 = "fab387"; base0A = "f9e2af"; base0B = "a6e3a1";
    base0C = "94e2d5"; base0D = "89b4fa"; base0E = "cba6f7"; base0F = "f2cdcd";
  };
in
{
  services.dunst = {
    enable = true;

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };

    settings = {
      global = {
        follow = "keyboard";
        width = 370;
        separator_height = 1;
        padding = 24;
        horizontal_padding = 24;
        frame_width = 1;
        sort = "update";
        idle_threshold = 120;
        alignment = "center";
        word_wrap = "yes";
        transparency = 5;
        format = "<b>%s</b>: %b";
        markup = "full";
        min_icon_size = 32;
        max_icon_size = 128;
        highlight = mkForce "#${palette.base03}";
      };

      urgency_low = {
        foreground = mkForce "#${palette.base0A}";
        frame_color = mkForce "#${palette.base02}";
      };

      urgency_normal.frame_color = mkForce "#${palette.base02}";

      urgency_critical = {
        foreground = mkForce "#${palette.base08}";
        frame_color = mkForce "#${palette.base02}";
      };
    };
  };
}
