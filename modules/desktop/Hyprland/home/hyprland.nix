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

    settings.exec-once = [ "systemctl --user start hyprpolkitagent" ];

    extraConfig = let
      modifier = "SUPER";
    in concatStrings [
      ''

      # ── Environment Variables ─────────────────────────────────────────────
      env = NIXOS_OZONE_WL, 1
      env = NIXPKGS_ALLOW_UNFREE, 1
      env = XDG_CURRENT_DESKTOP, Hyprland
      env = XDG_SESSION_TYPE, wayland
      env = XDG_SESSION_DESKTOP, Hyprland
      env = GDK_BACKEND, wayland,x11
      env = CLUTTER_BACKEND, wayland
      env = QT_QPA_PLATFORM,wayland;xcb
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
      env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
      env = SDL_VIDEODRIVER, wayland
      env = MOZ_ENABLE_WAYLAND, 1

      # ── Startup Programs ──────────────────────────────────────────────────
      exec-once = dbus-update-activation-environment --systemd --all
      exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = swww init # Start swww daemon if not running
      exec-once = swaync # Start notification daemon
      exec-once = nm-applet --indicator
      exec-once = kdeconnect-indicator # Start kdeconnect indicator earlier
      exec-once = wl-paste --type text --watch cliphist store
      exec-once = wl-paste --type image --watch cliphist store
      exec-once = sleep 1 && swww img /home/${username}/Pictures/Wallpapers/${wallpaper} # Set wallpaper after swww is ready

      # ── Monitor Setup ─────────────────────────────────────────────────────
      monitor = eDP-1,1920x1080@60,0x0,1
      ${extraMonitorSettings}

      # ── General Settings ──────────────────────────────────────────────────
      general {
        gaps_in           = 5 # Increased for a bit more spacing
        gaps_out          = 10 # Increased for a bit more spacing
        border_size       = 2
        layout            = dwindle
        resize_on_border  = true
        allow_tearing     = false # Recommended for smoother visuals
        col.active_border   = rgb(${config.stylix.base16Scheme.base08}) rgb(${config.stylix.base16Scheme.base0C}) 45deg
        col.inactive_border = rgb(${config.stylix.base16Scheme.base01})
      }

      # ── Input Settings ─────────────────────────────────────────────────────
      input {
        kb_layout  = us # Add other layouts if needed, e.g., us,ru
        kb_options = grp:alt_shift_toggle
        kb_options = caps:super
        follow_mouse = 1
        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        accel_profile = flat

        touchpad {
          natural_scroll = true
          disable_while_typing = true # Nice to have: disable touchpad while typing
        }
      }

      gestures {
        workspace_swipe = true
      }

      misc {
        initial_workspace_tracking = 0
        mouse_move_enables_dpms    = true
        key_press_enables_dpms     = false # User preference
        # enable_swallow = true # Optional: consider if you use terminal extensively for media
        # swallow_regex = ^(kitty|alacritty)$ # Example for swallow
      }

      # ── Animations ─────────────────────────────────────────────────────────
      animations {
        enabled = yes

        bezier = smooth, 0.25, 0.75, 0.5, 1 # Your custom bezier curve

        # Faster animation speeds
        animation = windows,     1, 0.3, smooth, slide   # Was 0.5
        animation = windowsIn,   1, 0.25, smooth, slide  # Was 0.4
        animation = windowsOut,  1, 0.25, smooth, slide  # Was 0.4
        animation = windowsMove, 1, 0.2, smooth, slide   # Was 0.3

        animation = border,      1, 0.15, smooth         # Was 0.2
        animation = fade,        1, 0.15, smooth         # Was 0.2
        animation = workspaces,  1, 0.3, smooth          # Was 0.5
      }

      # ── Decoration ─────────────────────────────────────────────────────────
      decoration {
        rounding = 10 # Added rounded corners

        # Optional: Drop shadow for a nicer look (can affect performance slightly)
        # drop_shadow = yes
        # shadow_range = 10
        # shadow_render_power = 2
        # col.shadow = rgba(00000055)
        # col.shadow_inactive = rgba(00000033)

        blur {
          enabled           = true
          size              = 2 # Lower for less blur, higher for more
          passes            = 3 # More passes for smoother blur, can impact performance
          new_optimizations = on
          ignore_opacity    = off
          # xray = true # Consider if you want to see through blurred windows slightly
        }
      }

      dwindle {
        pseudotile   = true
        preserve_split = true
      }

      # ── Window Rules (Examples - uncomment and customize as needed)─────
      # Make polkit agent and other utility windows float
      # windowrulev2 = float,class:^(org.kde.polkit-kde-authentication-agent-1)$
      # windowrulev2 = float,class:^(xdg-desktop-portal-gtk)$
      # windowrulev2 = float,class:^(xdg-desktop-portal-hyprland)$
      # windowrulev2 = float,title:^(Open File)$
      # windowrulev2 = float,title:^(Save File)$
      # windowrulev2 = float,title:^(Select Color)$ # For hyprpicker or similar
      # windowrulev2 = float,class:^(pavucontrol)$
      # windowrulev2 = float,class:^(blueman-manager)$
      # windowrulev2 = float,class:^(nm-connection-editor)$
      # windowrulev2 = float,class:^(emote-picker)$ # If emopicker9000 is a GTK app with this class

      # Assign applications to specific workspaces
      # windowrulev2 = workspace 2,class:^(${browser})$ # Example: Open browser on workspace 2
      # windowrulev2 = workspace 3,class:^(discord)$   # Example: Open Discord on workspace 3

      # Idle inhibition rules (prevent screen sleep for certain apps)
      # windowrulev2 = idleinhibit focus,class:^(mpv|vlc|kodi|.+exe)$ # For media players and games
      # windowrulev2 = idleinhibit fullscreen,class:^(firefox|${browser})$ # For browser in fullscreen video

      # ── Keybindings ────────────────────────────────────────────────────────
      bind = ${modifier},Return,exec,${terminal}
      bind = ${modifier}SHIFT,Return,exec,rofi -show drun
      bind = ${modifier},V,exec,cliphist list | rofi -dmenu | cliphist decode | wl-copy
      bind = ${modifier}ALT,W,exec,wallSelector
      bind = ${modifier}SHIFT,N,exec,swaync-client -rs
      bind = ${modifier},W,exec,${browser}
      bind = ${modifier}SHIFT,L,exec,wlogout
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

      bind = ${modifier}SHIFT,W,exec,better-control -w

      # ── Window Movement ────────────────────────────────────────────────────
      bind = ${modifier}SHIFT,left, movewindow,l
      bind = ${modifier}SHIFT,right,movewindow,r
      bind = ${modifier}SHIFT,up,   movewindow,u
      bind = ${modifier}SHIFT,down, movewindow,d
      bind = ${modifier}SHIFT,h,    movewindow,l
      bind = ${modifier}SHIFT,l,    movewindow,r
      bind = ${modifier}SHIFT,k,    movewindow,u
      bind = ${modifier}SHIFT,j,    movewindow,d

      # ── Focus Movement ─────────────────────────────────────────────────────
      bind = ${modifier},left, movefocus,l
      bind = ${modifier},right,movefocus,r
      bind = ${modifier},up,   movefocus,u
      bind = ${modifier},down, movefocus,d
      bind = ${modifier},h,    movefocus,l
      bind = ${modifier},k,    movefocus,u # Added for consistency
      bind = ${modifier},j,    movefocus,d
      bind = ${modifier},l,    movefocus,r # Added for consistency

      # ── Workspaces ─────────────────────────────────────────────────────────
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

      bind = ${modifier}SHIFT,SPACE,movetoworkspace,special
      bind = ${modifier},SPACE,togglespecialworkspace
      bind = ${modifier}CONTROL,right,workspace,e+1
      bind = ${modifier}CONTROL,left, workspace,e-1
      bind = ${modifier},mouse_down,workspace,e+1
      bind = ${modifier},mouse_up,  workspace,e-1

      # ── Mouse Bindings ─────────────────────────────────────────────────────
      bindm = ${modifier},mouse:272,movewindow
      bindm = ${modifier},mouse:273,resizewindow

      # ── Grouping ───────────────────────────────────────────────────────────
      # bind = ALT,Tab,cyclenext
      bind = ${modifier},G,togglegroup
      # bind = ${modifier}CTRL,tab,changegroupactive # Consider if this conflicts with browser tab switching
      bind = ALT,Tab,changegroupactive # This will likely override the cyclenext above for ALT,Tab

      # ── Media Keys ─────────────────────────────────────────────────────────
      bind  = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bind  = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      binde = ,XF86AudioMute,        exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind  = ,XF86AudioPlay,        exec,playerctl play-pause
      bind  = ,XF86AudioPause,       exec,playerctl play-pause
      bind  = ,XF86AudioNext,        exec,playerctl next
      bind  = ,XF86AudioPrev,        exec,playerctl previous
      bind  = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
      bind  = ,XF86MonBrightnessUp,  exec,brightnessctl set +5%
      ''
    ];
  };
}
