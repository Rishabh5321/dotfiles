{ lib, pkgs, config, ... }:

let
  inherit (import ../misc/variables.nix) browser terminal extraMonitorSettings;
in
with lib; {
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };

    extraConfig =
      let
        modifier = "SUPER";
      in
      concatStrings [
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
      env = WLR_RENDERER,vulkan

      # ── Startup Programs ──────────────────────────────────────────────────
      exec-once = dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = swaync # Start notification daemon
      exec-once = nm-applet --indicator
      exec-once = systemctl --user start hyprpolkitagent
      exec-once = kdeconnect-indicator # Start kdeconnect indicator earlier
      exec-once = wl-paste --type text --watch cliphist store
      exec-once = wl-paste --type image --watch cliphist store

      # ── Monitor Setup ─────────────────────────────────────────────────────
      monitor = eDP-1,1920x1080@60,0x0,1
      ${extraMonitorSettings}

      # ── General Settings ──────────────────────────────────────────────────
      general {
        gaps_in           = 4
        gaps_out          = 4
        border_size       = 2
        layout            = dwindle
        resize_on_border  = true
        extend_border_grab_area = 15
        hover_icon_on_border = true
        allow_tearing     = false
        col.active_border   = rgb(${config.stylix.base16Scheme.base0D}) rgb(${config.stylix.base16Scheme.base0B}) 45deg
        col.inactive_border = rgb(${config.stylix.base16Scheme.base00})
      }

      # ── Input Settings ─────────────────────────────────────────────────────
      input {
        kb_layout  = us
        kb_options = grp:alt_shift_toggle,caps:super
        follow_mouse = 1
        mouse_refocus = false
        sensitivity = 0
        accel_profile = flat
        force_no_accel = true

        touchpad {
          natural_scroll = true
          disable_while_typing = true
          tap-to-click = true
          tap-and-drag = true
          drag_lock = false
          scroll_factor = 1.0
        }
      }

      gestures {
        # workspace_swipe = true
        # workspace_swipe_fingers = 3
        workspace_swipe_distance = 300
        workspace_swipe_cancel_ratio = 0.5
        workspace_swipe_min_speed_to_force = 30
        workspace_swipe_create_new = true
      }

      misc {
        initial_workspace_tracking = 0
        mouse_move_enables_dpms    = true
        key_press_enables_dpms     = true
        always_follow_on_dnd       = true
        layers_hog_keyboard_focus  = true
        animate_manual_resizes     = false
        animate_mouse_windowdragging = false
        disable_hyprland_logo      = false
        disable_splash_rendering   = false
        force_default_wallpaper    = 0
        vfr = true
        vrr = 0
        # render_ahead_of_time = false
        # render_ahead_safezone = 1
        enable_swallow = true
        swallow_regex = ^(kitty|alacritty|foot|ghostty)$
        swallow_exception_regex = ^(wev)$
      }

      # ── Snappier Animations ───────────────────────────────────────────────
      animations {
        enabled = yes

        bezier = snap, 0.1, 0, 0.2, 1
        bezier = linear, 0, 0, 1, 1
        bezier = md3_standard, 0.2, 0, 0, 1
        bezier = md3_decel, 0.05, 0.7, 0.1, 1
        bezier = md3_accel, 0.3, 0, 0.8, 0.15
        bezier = overshot, 0.05, 0.9, 0.1, 1.1
        bezier = crazyshot, 0.1, 1.5, 0.76, 0.92
        bezier = hyprnostretch, 0.05, 0.9, 0.1, 1.0
        bezier = fluent_decel, 0.1, 1, 0, 1
        bezier = easeInOutCirc, 0.85, 0, 0.15, 1
        bezier = easeOutCirc, 0, 0.55, 0.45, 1
        bezier = easeOutExpo, 0.16, 1, 0.3, 1

        # Snappy window animations
        animation = windows, 1, 3, md3_decel, slide
        animation = windowsIn, 1, 3, md3_decel, slide
        animation = windowsOut, 1, 3, md3_accel, slide
        animation = windowsMove, 1, 2, linear, slide

        animation = fade, 1, 2, md3_decel
        animation = fadeIn, 1, 2, md3_decel
        animation = fadeOut, 1, 2, md3_accel
        animation = fadeSwitch, 0, 1, linear
        animation = fadeShadow, 1, 2, md3_decel
        animation = fadeDim, 1, 2, fluent_decel

        animation = border, 1, 2.7, md3_decel
        animation = borderangle, 1, 2.7, fluent_decel, once

        animation = workspaces, 1, 2, md3_decel, slide
        animation = specialWorkspace, 1, 2, md3_decel, slidevert

        animation = layers, 1, 2, md3_decel, slide
        animation = layersIn, 1, 2, md3_decel, slide
        animation = layersOut, 1, 2, md3_accel, slide
      }

      # ── Decoration ─────────────────────────────────────────────────────────
      decoration {
        rounding = 6

        # active_opacity = 1.0
        # inactive_opacity = 0.95
        # fullscreen_opacity = 1.0

        dim_inactive = false
        dim_strength = 0.1
        dim_special = 0.8

        # blur {
        #   enabled = true
        #   size = 6
        #   passes = 3
        #   ignore_opacity = true
        #   new_optimizations = true
        #   xray = false
        #   noise = 0.0117
        #   contrast = 1.5000
        #   brightness = 1.0
        #   vibrancy = 0.2
        #   vibrancy_darkness = 0.5
        #   special = false
        # }
      }

      # ── Layout Settings ────────────────────────────────────────────────────
      dwindle {
        pseudotile = true
        preserve_split = true
        smart_split = false
        smart_resizing = true
        permanent_direction_override = false
        special_scale_factor = 1.0
        split_width_multiplier = 1.0
        # no_gaps_when_only = 0
        use_active_for_splits = true
        default_split_ratio = 1.0
      }

      master {
        allow_small_split = false
        special_scale_factor = 1.0
        mfact = 0.55
        # new_is_master = true
        # new_on_top = false
        # no_gaps_when_only = 0
        orientation = left
        inherit_fullscreen = true
        # always_center_master = false
        smart_resizing = true
        drop_at_cursor = true
      }

      # ── Keybindings ────────────────────────────────────────────────────────
      # Application launchers
      bind = ${modifier},Return,exec,${terminal}
      bind = ALT,SPACE,exec,rofi -show drun
      bind = ${modifier},R,exec,rofi -show run
      bind = ${modifier},V,exec,cliphist list | rofi -dmenu | cliphist decode | wl-copy
      bind = ${modifier}CTRL,W,exec,waypaper
      bind = ${modifier},W,exec,${browser}
      bind = ${modifier}SHIFT,L,exec,wlogout
      bind = ${modifier},E,exec,emopicker9000
      bind = ${modifier},S,exec,screenshootin
      bind = ${modifier}SHIFT,S,exec,grim -g "$(slurp)" - | swappy -f -
      bind = ${modifier},D,exec,discord
      bind = ${modifier},C,exec,hyprpicker -a
      bind = ${modifier},T,exec,thunar
      bind = ${modifier},M,exec,spotify
      bind = ${modifier},N,exec,swaync-client -t -sw

      # Window management
      bind = ${modifier},Q,killactive,
      bind = ${modifier},P,pseudo,
      bind = ${modifier}SHIFT,I,togglesplit,
      bind = ${modifier},F,fullscreen,
      bind = ${modifier}SHIFT,F,togglefloating,
      bind = ${modifier}SHIFT,C,exit,
      bind = ${modifier}SHIFT,P,pin,
      # bind = ${modifier}SHIFT,O,toggleopaque,

      # Better control integration
      bind = ${modifier}SHIFT,W,exec,better-control -w

      # ── Enhanced Window Movement ───────────────────────────────────────────
      bind = ${modifier}SHIFT,left, movewindow,l
      bind = ${modifier}SHIFT,right,movewindow,r
      bind = ${modifier}SHIFT,up,   movewindow,u
      bind = ${modifier}SHIFT,down, movewindow,d
      bind = ${modifier}SHIFT,h,    movewindow,l
      bind = ${modifier}SHIFT,l,    movewindow,r
      bind = ${modifier}SHIFT,k,    movewindow,u
      bind = ${modifier}SHIFT,j,    movewindow,d

      # Resize windows
      bind = ${modifier}CONTROL,left, resizeactive,-50 0
      bind = ${modifier}CONTROL,right,resizeactive,50 0
      bind = ${modifier}CONTROL,up,   resizeactive,0 -50
      bind = ${modifier}CONTROL,down, resizeactive,0 50
      bind = ${modifier}CONTROL,h,    resizeactive,-50 0
      bind = ${modifier}CONTROL,l,    resizeactive,50 0
      bind = ${modifier}CONTROL,k,    resizeactive,0 -50
      bind = ${modifier}CONTROL,j,    resizeactive,0 50

      # ── Focus Movement ─────────────────────────────────────────────────────
      bind = ${modifier},left, movefocus,l
      bind = ${modifier},right,movefocus,r
      bind = ${modifier},up,   movefocus,u
      bind = ${modifier},down, movefocus,d
      bind = ${modifier},h,    movefocus,l
      bind = ${modifier},k,    movefocus,u
      bind = ${modifier},j,    movefocus,d
      bind = ${modifier},l,    movefocus,r

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

      # Special workspace (scratchpad)
      bind = ${modifier}SHIFT,SPACE,movetoworkspace,special
      bind = ${modifier},SPACE,togglespecialworkspace

      # Workspace navigation
      bind = ${modifier}CONTROL,right,workspace,e+1
      bind = ${modifier}CONTROL,left, workspace,e-1
      bind = ${modifier},mouse_down,workspace,e+1
      bind = ${modifier},mouse_up,  workspace,e-1

      # ── Mouse Bindings ─────────────────────────────────────────────────────
      bindm = ${modifier},mouse:272,movewindow
      bindm = ${modifier},mouse:273,resizewindow
      bind = ${modifier},mouse:274,togglefloating

      # ── Grouping ───────────────────────────────────────────────────────────
      bind = ${modifier},G,togglegroup
      bind = ALT,Tab,changegroupactive
      bind = ${modifier}ALT,Tab,cyclenext,prev

      # ── Media Keys ─────────────────────────────────────────────────────────
      bindel = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bindel = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindl  = ,XF86AudioMute,        exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindl  = ,XF86AudioPlay,        exec,playerctl play-pause
      bindl  = ,XF86AudioPause,       exec,playerctl play-pause
      bindl  = ,XF86AudioNext,        exec,playerctl next
      bindl  = ,XF86AudioPrev,        exec,playerctl previous
      bindel = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
      bindel = ,XF86MonBrightnessUp,  exec,brightnessctl set +5%

      # ── Quick Actions ──────────────────────────────────────────────────────
      bind = ${modifier}ALT,L,exec,swaylock
      bind = ${modifier}ALT,R,exec,hyprctl reload
      bind = ${modifier}ALT,K,exec,hyprctl kill
      bind = CTRLALT,Delete,exec,wlogout
      ''
      ];
  };
}
