{ config
, wallpaper
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

    sourceFirst = true;
  };
  xdg.configFile."hypr/hyprlock.conf".text = ''
    general {
        grace = 1
    }

    background {
        monitor =
    	#path = screenshot   # screenshot of your desktop
    	path = ~/Pictures/Wallpapers/${wallpaper}  # NOTE only png supported for now
        #color = ${color0}

        # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
        blur_size = 8
        blur_passes = 4 # 0 disables blurring
        noise = 0.0117
        contrast = 1.1 # Vibrant!!!
        brightness = 0.8000
        vibrancy = 0.16
        vibrancy_darkness = 0.0
    }

    input-field {
        monitor =
        size = 250, 50
        outline_thickness = 2
        dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true
        outer_color = ${color14}
        inner_color = ${color0}
        font_color = ${color5}
        fade_on_empty = true
        placeholder_text = <i>Password...</i> # Text rendered in the input box when it's empty.
        hide_input = false
        rounding = 12

        position = 0, -80
        halign = center
        valign = center
    }

    # Date
    label {
        monitor =
        text = cmd[update:18000000] echo "<b> "$(date +'%A, %-d %B %Y')" </b>"
        color = ${color14}
        font_size = 24
        font_family = JetBrains Mono Nerd Font Mono ExtraBold
        position = 0, 80
        halign = center
        valign = center
    }

    # Hour-Time
    label {
        monitor =
    #     text = cmd[update:1000] echo -e "$(date +"%H")"
        text = cmd[update:1000] echo -e "$(date +"%I:%M")" #AM/PM
        color = rgba(255, 255, 255, .6)
        font_size = 90
        font_family = JetBrains Mono Nerd Font Mono ExtraBold
        position = 0, 120
        halign = center
        valign = center
    }

    # User
    label {
        monitor =
        text =    $USER
        color = ${color14}
        font_size = 18
        font_family = Inter Display Medium

        position = 0, 100
        halign = center
        valign = bottom
    }

    # uptime
    label {
        monitor =
        text = cmd[update:60000] echo "<b> "$(uptime -p || $Scripts/UptimeNixOS.sh)" </b>"
        color = ${color14}
        font_size = 16
        font_family = JetBrains Mono Nerd Font Mono ExtraBold
        position = 20, 20
        halign = right
        valign = bottom
    }

    # weather edit the scripts for locations
    # weather scripts are located in ~/.config/hypr/UserScripts Weather.sh and/or Weather.py
    # see https://github.com/JaKooLit/Hyprland-Dots/wiki/TIPS#%EF%B8%8F-weather-app-related-for-waybar-and-hyprlock
    label {
        monitor =
        text = cmd[update:3600000] [ -f ~/.cache/.weather_cache ] && cat  ~/.cache/.weather_cache
        color = ${color14}
        font_size = 16
        font_family = JetBrains Mono Nerd Font Mono ExtraBold
        position = 20, 20
        halign = left
        valign = bottom
    }

    # Put a picture of choice here. Default is the current wallpaper
    # image {
    #     monitor =
    #     path = $HOME/.config/hypr/wallpaper_effects/.wallpaper_current
    #     size = 230
    #     rounding = -1
    #     border_size = 2
    #     border_color = ${color14}
    #     rotate = 0
    #     reload_time = -1
    #     position = 0, 300
    #     halign = center
    #     valign = bottom
    # }
  '';
}
