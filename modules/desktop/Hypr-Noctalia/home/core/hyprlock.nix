{ config
, lib
, wallpaper
, wallpapers
, inputs
, pkgs
, ...
}:
let
  color0 = "rgb(${config.stylix.base16Scheme.base00})";
  color5 = "rgb(${config.stylix.base16Scheme.base05})";
  color14 = "rgb(${config.stylix.base16Scheme.base0E})";
in
{
  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;
    settings = {
      general = {
        grace = 1;
      };
      background = {
        path = lib.mkForce "${wallpapers}/${wallpaper}";
        blur_size = 5;
        blur_passes = 1;
        noise = 0.0117;
        contrast = 1.3;
        brightness = 0.8;
        vibrancy = 0.21;
        vibrancy_darkness = 0.0;
      };
      "input-field" = {
        size = "250, 50";
        outline_thickness = 3;
        dots_size = 0.33;
        dots_spacing = 0.15;
        dots_center = true;
        outer_color = lib.mkForce color5;
        inner_color = lib.mkForce color0;
        font_color = lib.mkForce color14;
        fade_on_empty = true;
        placeholder_text = "<i>Password...</i>";
        hide_input = false;
        position = "0, 40";
        halign = "center";
        valign = "bottom";
      };
      "label" = lib.mkForce [
        {
          text = "cmd[update:18000000] echo \"<b> $(date +'%A, %-d %B %Y') </b>\"";
          color = color14;
          font_size = 34;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -100";
          halign = "center";
          valign = "top";
        }
        {
          text = "cmd[update:1000] echo -e \"$(date +'%I')\""; #AM/PM
          color = "rgba(255, 185, 0, .6)";
          font_size = 200;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -200";
          halign = "center";
          valign = "top";
        }
        {
          text = "cmd[update:1000] echo -e \"$(date +'%M')\"";
          color = "rgba(255, 255, 255, .6)";
          font_size = 200;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -500";
          halign = "center";
          valign = "top";
        }
        {
          text = "cmd[update:1000] echo -e \"$(date +'%S %p')\""; #AM/PM
          color = color14;
          font_size = 40;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -500";
          halign = "center";
          valign = "top";
        }
        {
          text = "   $USER";
          color = color14;
          font_size = 18;
          font_family = "Inter Display Medium";
          position = "0, 100";
          halign = "center";
          valign = "bottom";
        }
        {
          text = "cmd[update:60000] echo \"<b> $(uptime -p || $Scripts/UptimeNixOS.sh) </b>\"";
          color = color14;
          font_size = 24;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, 0";
          halign = "right";
          valign = "bottom";
        }
        {
          text = "cmd[update:3600000] [ -f ~/.cache/.weather_cache ] && cat  ~/.cache/.weather_cache";
          color = color14;
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
