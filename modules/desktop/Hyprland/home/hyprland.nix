{ lib, username, pkgs, config, wallpaper, inputs, ... }:

let
  inherit (import ./variables.nix) browser terminal extraMonitorSettings;
in
with lib; {
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    xwayland.enable = true;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    systemd.enable = true;

    settings.exec-once = [
      "systemctl --user start hyprpolkitagent"
    ];

    extraConfig = let modifier = "SUPER"; in concatStrings [
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
        env = SDL_VIDEODRIVER, wayland
        env = MOZ_ENABLE_WAYLAND, 1

        exec-once = dbus-update-activation-environment --systemd --all
        exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        exec-once = killall -q swww; sleep 0.5 && swww init
        exec-once = killall -q swaync; sleep 0.5 && swaync
        exec-once = nm-applet --indicator
        exec-once = sleep 5 && kdeconnect-settings && kdeconnect-indicator
        exec-once = wl-paste --type text --watch cliphist store
        exec-once = wl-paste --type image --watch cliphist store
        exec-once = sleep 1.5 && swww img /home/${username}/Pictures/Wallpapers/${wallpaper}

        monitor = eDP-1,1920x1080@60,0x0,1
        ${extraMonitorSettings}

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
          sensitivity = 0
          accel_profile = flat
        }

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

          # Bezier curves
          bezier = smooth, 0.25, 0.75, 0.5, 1

          # Window animations
          animation = windows,     1, 0.5, smooth, slide
          animation = windowsIn,   1, 0.4, smooth, slide
          animation = windowsOut,  1, 0.4, smooth, slide
          animation = windowsMove, 1, 0.3, smooth, slide

          # Other animations
          animation = border,      1, 0.2, smooth
          animation = fade,        1, 0.2, smooth
          animation = workspaces,  1, 0.5, smooth
        }


        decoration {
          rounding = 4
          blur {
            enabled = true
            size = 2
            passes = 3
            new_optimizations = on
            ignore_opacity = off
          }
        }

        dwindle {
          pseudotile = true
          preserve_split = true
        }

        # Binds
        bind = ${modifier},Return,exec,${terminal}
        bind = ${modifier}SHIFT,Return,exec,rofi -show drun
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
        bind = ${modifier},K,exec,tv.kodi.Kodi
        bind = ${modifier}SHIFT,G,exec,godot4
        bind = ${modifier},T,exec,thunar
        bind = ${modifier},M,exec,spotify
        bind = ${modifier},Q,killactive,
        bind = ${modifier},P,pseudo,
        bind = ${modifier}SHIFT,I,togglesplit,
        bind = ${modifier},F,fullscreen,
        bind = ${modifier}SHIFT,F,togglefloating,
        bind = ${modifier}SHIFT,C,exit,

        # Window movement
        bind = ${modifier}SHIFT,left,movewindow,l
        bind = ${modifier}SHIFT,right,movewindow,r
        bind = ${modifier}SHIFT,up,movewindow,u
        bind = ${modifier}SHIFT,down,movewindow,d
        bind = ${modifier}SHIFT,h,movewindow,l
        bind = ${modifier}SHIFT,l,movewindow,r
        bind = ${modifier}SHIFT,k,movewindow,u
        bind = ${modifier}SHIFT,j,movewindow,d

        # Focus movement
        bind = ${modifier},left,movefocus,l
        bind = ${modifier},right,movefocus,r
        bind = ${modifier},up,movefocus,u
        bind = ${modifier},down,movefocus,d
        bind = ${modifier},h,movefocus,l
        bind = ${modifier},j,movefocus,d

        # Workspaces
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
        bind = ${modifier},mouse_down,workspace,e+1
        bind = ${modifier},mouse_up,workspace,e-1

        # Mouse bindings
        bindm = ${modifier},mouse:272,movewindow
        bindm = ${modifier},mouse:273,resizewindow

        # Grouping
        bind = ALT,Tab,cyclenext
        bind = ${modifier},G,togglegroup
        bind = ${modifier}CTRL,tab,changegroupactive
        bind = ALT,Tab,bringactivetotop

        # Media keys
        bind = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        bind = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        binde = ,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bind = ,XF86AudioPlay,exec,playerctl play-pause
        bind = ,XF86AudioPause,exec,playerctl play-pause
        bind = ,XF86AudioNext,exec,playerctl next
        bind = ,XF86AudioPrev,exec,playerctl previous
        bind = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
        bind = ,XF86MonBrightnessUp,exec,brightnessctl set +5%
      ''
    ];
  };
}
