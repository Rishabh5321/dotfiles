{ config
, lib
, pkgs
, ...
}:

let
  stylixEnabled = config ? stylix && config.stylix.enable;
  palette = if stylixEnabled then config.stylix.base16Scheme else {
    base00 = "000000";
    base01 = "1e1e2e";
    base02 = "313244";
    base03 = "45475a";
    base04 = "585b70";
    base05 = "cdd6f4";
    base06 = "f5e0dc";
    base07 = "b4befe";
    base08 = "f38ba8";
    base09 = "fab387";
    base0A = "f9e2af";
    base0B = "a6e3a1";
    base0C = "94e2d5";
    base0D = "89b4fa";
    base0E = "cba6f7";
    base0F = "f2cdcd";
  };
  color0 = "rgb(${palette.base00})";
  color5 = "rgb(${palette.base05})";
  color14 = "rgb(${palette.base0E})";
in
{
  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;
    settings = {
      general = {
        disable_loading = true;
        hide_cursor = false;
        grace = 0;
        no_fade_in = false;
      };

      background = lib.mkForce [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = lib.mkForce [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = if stylixEnabled then lib.mkForce color14 else color5;
          inner_color = if stylixEnabled then lib.mkForce color0 else color0;
          outer_color = if stylixEnabled then lib.mkForce color5 else color5;
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];

      label = lib.mkForce [
        {
          monitor = "";
          text = "$TIME";
          color = if stylixEnabled then lib.mkForce color14 else color14;
          font_size = 120;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "Hi there, $USER";
          color = if stylixEnabled then lib.mkForce color14 else color14;
          font_size = 25;
          font_family = "JetBrains Mono Nerd Font Mono";
          position = "0, -40";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +'%A, %d %B')\"";
          color = if stylixEnabled then lib.mkForce color14 else color14;
          font_size = 24;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, 10";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = " $USER";
          color = if stylixEnabled then lib.mkForce color14 else color14;
          font_size = 18;
          font_family = "JetBrains Mono Nerd Font Mono";
          position = "0, 100";
          halign = "center";
          valign = "bottom";
        }
        {
          monitor = "";
          text = "󰌾 Lock Screen";
          color = if stylixEnabled then lib.mkForce color14 else color14;
          font_size = 24;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "50, 0";
          halign = "left";
          valign = "bottom";
        }
      ];
    };
  };
}
