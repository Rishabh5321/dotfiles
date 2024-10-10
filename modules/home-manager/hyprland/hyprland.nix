{ lib
, username
, config
, wallpaper
, ...
}:
let
  # hyprplugins = inputs.hyprland-plugins.packages.${pkgs.system};
  inherit (import ./variables.nix) browser terminal extraMonitorSettings;
in
with lib; {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
      extraCommands = [ "systemctl --user start hypridle.service" ];
    };
    # plugins = [
    #   hyprplugins.hyprtrails
    # ];
    #settings.exec-once = [ "hypridle" ];
    extraConfig =
      let
        modifier = "SUPER";
      in
      concatStrings [
        ''
                    env = NIXOS_OZONE_WL, 1
                    env = NIXPKGS_ALLOW_UNFREE, 1
                    env = XDG_CURRENT_DESKTOP, Hyprland
                    env = XDG_SESSION_TYPE, wayland
                    env = XDG_SESSION_DESKTOP, Hyprland
                    env = GDK_BACKEND, wayland, x11
                    env = CLUTTER_BACKEND, wayland
                    env = QT_QPA_PLATFORM=wayland;xcb
                    env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
                    env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
                    env = SDL_VIDEODRIVER, x11
                    env = MOZ_ENABLE_WAYLAND, 1
                    exec-once = dbus-update-activation-environment --systemd --all
                    exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
                    exec-once = killall -q swww;sleep .5 && swww init
                    exec-once = killall -q waybar;sleep .5 && waybar
                    exec-once = killall -q swaync;sleep .5 && swaync
                    exec-once = nm-applet --indicator
                    #exec-once = lxqt-policykit-agent
                    #exec-once = hyprlock --immediate
                    #exec-once = sleep 1.5 && startup
                    exec-once = sleep 5 && kdeconnect-settings && kdeconnect-indicator
                    exec-once = wl-paste --type text --watch cliphist store #Stores only text data
                    exec-once = wl-paste --type image --watch cliphist store #Stores only image data
                    exec-once = sleep 1.5 && swww img /home/${username}/Pictures/Wallpapers/${wallpaper}
                    monitor=eDP-1,preferred,1600x0,1
                    monitor=DP-1,preferred,0x0,1
                    ${extraMonitorSettings}
                    # plugin {
                    #   hyprtrails {
                    #       color = rgb(${config.stylix.base16Scheme.base08})
                    #   }
                    # }
                    general {
                      gaps_in = 4
                      gaps_out = 6
                      border_size = 3
                      layout = dwindle
                      resize_on_border = true
                      allow_tearing = true
                      col.active_border = rgb(${config.stylix.base16Scheme.base08}) rgb(${config.stylix.base16Scheme.base0C}) 45deg
                      col.inactive_border = rgb(${config.stylix.base16Scheme.base01})
                    }
                    input {
                      kb_layout = us
                      kb_options = grp:alt_shift_toggle
                      kb_options = caps:super
                      follow_mouse = 1
                      touchpad {
                        natural_scroll = true
                      }
                      sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
                      accel_profile = flat
                    }
                    windowrule = noborder,^(rofi)$
                    windowrule = center,^(rofi)$
                    windowrule = center,^(steam)$
                    windowrule = float, nm-connection-editor|blueman-manager
                    windowrule = float, swayimg|vlc|Viewnior|pavucontrol
                    windowrule = float, nwg-look|qt5ct|mpv
                    windowrule = float, zoom
                    windowrulev2 = stayfocused, title:^()$,class:^(steam)$
                    windowrulev2 = minsize 1 1, title:^()$,class:^(steam)$
                    windowrule = animation fade,^(wlogout)$
                    windowrule = animation fade,^(rofi)$,1,1.5
                    windowrule = fullscreen, ^(wlogout)$
                    gestures {
                      workspace_swipe = true
                    }
                    misc {
                      initial_workspace_tracking = 0
                      mouse_move_enables_dpms = true
                      key_press_enables_dpms = false
                    }
                    animations {
                      enabled = yes
                      bezier = wind, 0.25, 0.75, 0.5, 1
                      bezier = winIn, 0.42, 0, 0.58, 1
                      bezier = winOut, 0.33, 1, 0.68, 1
                      bezier = liner, 0.5, 0, 0.5, 1
                      animation = windows, 1, 3, wind, slide
                      animation = windowsIn, 1, 2.5, winIn, slide
                      animation = windowsOut, 1, 2.5, winOut, slide
                      animation = windowsMove, 1, 2.5, wind, slide
                      animation = border, 1, 4, liner
                      animation = fadeIn, 1, 3, winIn
                      animation = fadeOut, 1, 3, winOut
                      animation = workspaces, 1, 5, wind
                      animation = windows, 1, 1.5, wind, slide
                      animation = windowsIn, 1, 1.5, winIn, slide
                      animation = windowsOut, 1, 1.5, winOut, slide
                      animation = windowsMove, 1, 1.5, wind, slide
                      animation = border, 1, 2, liner
                      animation = fade, 1, 2, default
                      animation = workspaces, 1, 2.5, wind
                    }
                    decoration {
                      rounding = 4
                      drop_shadow = false
                      shadow_range = 10
                      shadow_render_power = 3
                      col.shadow = rgba(1a1a1aee)
                      blur {
                          enabled = true
                          size = 2
                          passes = 3
                          new_optimizations = on
                          ignore_opacity = off
                      }
                    }
                    plugin {
                      hyprtrails {
                      }
                    }
                    dwindle {
                      pseudotile = true
                      preserve_split = true
                    }
                    bind = ${modifier},Return,exec,${terminal}
                    bind = ${modifier}SHIFT,Return,exec,rofi-launcher
                    bind = ${modifier},V,exec,cliphist list | rofi -dmenu | cliphist decode | wl-copy
                    bind = ${modifier}SHIFT,W,exec,web-search
                    bind = ${modifier}ALT,W,exec,wallSelector
                    bind = ${modifier}SHIFT,N,exec,swaync-client -rs
                    bind = ${modifier},W,exec,${browser}
                    bind = ${modifier},L,exec,wlogout
                    bind = ${modifier},E,exec,emopicker9000
                    bind = ${modifier},S,exec,screenshootin
                    bind = ${modifier},D,exec,discord
                    bind = ${modifier},C,exec,hyprpicker -a
                    bind = ${modifier}SHIFT,G,exec,godot4
                    bind = ${modifier},T,exec,thunar
                    bind = ${modifier},M,exec,spotify
                    bind = ${modifier},Q,killactive,
                    bind = ${modifier},P,pseudo,
                    bind = ${modifier}SHIFT,I,togglesplit,
                    bind = ${modifier},F,fullscreen,
                    bind = ${modifier}SHIFT,F,togglefloating,
                    bind = ${modifier}SHIFT,C,exit,
                    bind = ${modifier}SHIFT,left,movewindow,l
                    bind = ${modifier}SHIFT,right,movewindow,r
                    bind = ${modifier}SHIFT,up,movewindow,u
                    bind = ${modifier}SHIFT,down,movewindow,d
                    bind = ${modifier}SHIFT,h,movewindow,l
                    bind = ${modifier}SHIFT,l,movewindow,r
                    bind = ${modifier}SHIFT,k,movewindow,u
                    bind = ${modifier}SHIFT,j,movewindow,d
                    bind = ${modifier},left,movefocus,l
                    bind = ${modifier},right,movefocus,r
                    bind = ${modifier},up,movefocus,u
                    bind = ${modifier},down,movefocus,d
                    bind = ${modifier},h,movefocus,l
                    bind = ${modifier},k,movefocus,u
                    bind = ${modifier},j,movefocus,d
                    bind = ${modifier},1,workspace,1
                    bind = ${modifier},2,workspace,2
                    bind = ${modifier},3,workspace,3
                    bind = ${modifier},4,workspace,4
                    bind = ${modifier},5,workspace,5
                    bind = ${modifier},6,workspace,6
                    bind = ${modifier},7,workspace,7
                    bind = ${modifier},8,workspace,8
                    bind = ${modifier},9,workspace,9
                    bind = ${modifier},0,workspace,10
                    bind = ${modifier}SHIFT,SPACE,movetoworkspace,special
                    bind = ${modifier},SPACE,togglespecialworkspace
                    bind = ${modifier}SHIFT,1,movetoworkspace,1
                    bind = ${modifier}SHIFT,2,movetoworkspace,2
                    bind = ${modifier}SHIFT,3,movetoworkspace,3
                    bind = ${modifier}SHIFT,4,movetoworkspace,4
                    bind = ${modifier}SHIFT,5,movetoworkspace,5
                    bind = ${modifier}SHIFT,6,movetoworkspace,6
                    bind = ${modifier}SHIFT,7,movetoworkspace,7
                    bind = ${modifier}SHIFT,8,movetoworkspace,8
                    bind = ${modifier}SHIFT,9,movetoworkspace,9
                    bind = ${modifier}SHIFT,0,movetoworkspace,10
                    bind = ${modifier}CONTROL,right,workspace,e+1
                    bind = ${modifier}CONTROL,left,workspace,e-1
                    bind = ${modifier},mouse_down,workspace, e+1
                    bind = ${modifier},mouse_up,workspace, e-1
                    bindm = ${modifier},mouse:272,movewindow
                    bindm = ${modifier},mouse:273,resizewindow
                    bind = ALT,Tab,cyclenext
          bind = ${modifier}, G, togglegroup
          bind = ${modifier} CTRL, tab, changegroupactive  #change focus to another window
                    bind = ALT,Tab,bringactivetotop
                    bind = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
                    bind = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
                    binde = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
                    bind = ,XF86AudioPlay, exec, playerctl play-pause
                    bind = ,XF86AudioPause, exec, playerctl play-pause
                    bind = ,XF86AudioNext, exec, playerctl next
                    bind = ,XF86AudioPrev, exec, playerctl previous
                    bind = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
                    bind = ,XF86MonBrightnessUp,exec,brightnessctl set +5%
        ''
      ];
  };
}
