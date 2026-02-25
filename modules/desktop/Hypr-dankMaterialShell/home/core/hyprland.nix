{ lib
, pkgs
, config
, ...
}:

let
  inherit (import ../misc/variables.nix) browser terminal extraMonitorSettings;
  modifier = "SUPER";
in
with lib;
{
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    portalPackage =
      pkgs.xdg-desktop-portal-hyprland;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };
    settings = {
      # xwayland.enable = true;
      env = [
        "NIXOS_OZONE_WL,1"
        "NIXPKGS_ALLOW_UNFREE,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "GDK_BACKEND,wayland,x11"
        "CLUTTER_BACKEND,wayland"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "SDL_VIDEODRIVER,wayland"
        "MOZ_ENABLE_WAYLAND,1"
        "WLR_RENDERER,vulkan"
      ];
      # ── Startup Programs ──────────────────────────────────────────────────
      "exec-once" = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "swaync # Start notification daemon"
        # "caelestia shell -d"
        # "nm-applet --indicator"
        "systemctl --user start hyprpolkitagent"
        "kdeconnect-indicator # Start kdeconnect indicator earlier"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        # "sleep 5 &&"
        # "zen"
        # "obsidian"
        # "brave"
        # "discord"
        # "telegram-desktop"
      ];

      # ── Monitor Setup ─────────────────────────────────────────────────────
      monitor =
        [ "eDP-1,1920x1080@60,0x0,1" ]
        ++ (lib.filter (s: s != "") (lib.splitString "\n" extraMonitorSettings));

      # ── General Settings ──────────────────────────────────────────────────
      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        layout = "dwindle";
        resize_on_border = true;
        extend_border_grab_area = 15;
        hover_icon_on_border = true;
        allow_tearing = false;
        "col.active_border" = "rgb(${config.stylix.base16Scheme.base0D}) rgb(${config.stylix.base16Scheme.base0B}) 45deg";
        "col.inactive_border" = "rgb(${config.stylix.base16Scheme.base00})";
      };

      # ── Input Settings ─────────────────────────────────────────────────────
      input = {
        kb_layout = "us";
        kb_options = "grp:alt_shift_toggle,caps:super";
        follow_mouse = 1;
        mouse_refocus = false;
        sensitivity = 0;
        accel_profile = "flat";
        force_no_accel = true;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          "tap-to-click" = true;
          "tap-and-drag" = true;
          drag_lock = false;
          scroll_factor = 1.0;
        };
      };

      gestures = {
        # workspace_swipe = true
        # workspace_swipe_fingers = 3
        workspace_swipe_distance = 300;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_create_new = true;
      };

      "gesture" = "3, horizontal, workspace";

      misc = {
        initial_workspace_tracking = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        disable_hyprland_logo = false;
        disable_splash_rendering = false;
        force_default_wallpaper = 0;
        vfr = false;
        vrr = 0;
        # render_ahead_of_time = false
        # render_ahead_safezone = 1
        enable_swallow = true;
        swallow_regex = "^(kitty|alacritty|foot|ghostty)$";
        swallow_exception_regex = "^(wev)$";
      };

      # ── Snappier Animations ───────────────────────────────────────────────
      animations = {
        enabled = "yes";

        bezier = [
          "snap, 0.1, 0, 0.2, 1"
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];

        animation = [
          "windowsIn, 1, 3, default"
          "windowsOut, 1, 3, default"
          "workspaces, 1, 5, default"
          "windowsMove, 1, 4, default"
          "fade, 1, 3, default"
          "border, 1, 3, default"
        ];
      };

      # ── Decoration ─────────────────────────────────────────────────────────
      decoration = {
        rounding = 4;

        # active_opacity = 1.0
        # inactive_opacity = 0.95
        # fullscreen_opacity = 1.0

        dim_inactive = false;
        dim_strength = 0.1;
        dim_special = 0.8;

        # blur = {
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
      };

      # ── Layout Settings ────────────────────────────────────────────────────
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_split = false;
        smart_resizing = true;
        permanent_direction_override = false;
        special_scale_factor = 1.0;
        split_width_multiplier = 1.0;
        # no_gaps_when_only = 0
        use_active_for_splits = true;
        default_split_ratio = 1.0;
      };

      master = {
        allow_small_split = false;
        special_scale_factor = 1.0;
        mfact = 0.55;
        # new_is_master = true
        # new_on_top = false
        # no_gaps_when_only = 0
        orientation = "left";
        # inherit_fullscreen = true;
        # always_center_master = false
        smart_resizing = true;
        drop_at_cursor = true;
      };

      # ── Keybindings ────────────────────────────────────────────────────────
      bind = [
        # Application launchers
        "${modifier},Return,exec,${terminal}"
        "ALT,SPACE,exec,dms ipc call spotlight toggle"
        # "${modifier},R,exec,rofi -show run"
        "${modifier},V,exec,dms ipc call clipboard toggle"
        "${modifier}ALT,W,exec,wallSelector"
        "${modifier},W,exec,${browser}"
        "CTRL,L,exec,dms ipc call lock lock"
        # "${modifier},A,global,caelestia:session"
        "${modifier},E,exec,wofi-emoji"
        # "${modifier},S,global,caelestia:screenshot"
        "${modifier}SHIFT,S,exec,grim -g \"$(slurp)\" - | swappy -f -"
        "${modifier},D,exec,discord"
        "${modifier},C,exec,hyprpicker -a"
        "${modifier},T,exec,thunar"
        "${modifier},M,exec,spotify"
        "${modifier},N,exec,swaync-client -t -sw"

        # Window management
        "${modifier},Q,killactive,"
        "${modifier},P,pseudo,"
        "${modifier}SHIFT,I,togglesplit,"
        "${modifier},F,fullscreen,"
        "${modifier}SHIFT,F,togglefloating,"
        "${modifier}SHIFT,C,exit,"
        "${modifier}SHIFT,P,pin,"
        # "${modifier}SHIFT,O,toggleopaque,"

        # Better control integration
        "${modifier}SHIFT,W,exec,better-control -w"

        # ── Enhanced Window Movement ───────────────────────────────────────────
        "${modifier}SHIFT,left, movewindow,l"
        "${modifier}SHIFT,right,movewindow,r"
        "${modifier}SHIFT,up,   movewindow,u"
        "${modifier}SHIFT,down, movewindow,d"
        "${modifier}SHIFT,h,    movewindow,l"
        "${modifier}SHIFT,l,    movewindow,r"
        "${modifier}SHIFT,k,    movewindow,u"
        "${modifier}SHIFT,j,    movewindow,d"

        # Resize windows
        "${modifier}CONTROL,left, resizeactive,-50 0"
        "${modifier}CONTROL,right,resizeactive,50 0"
        "${modifier}CONTROL,up,   resizeactive,0 -50"
        "${modifier}CONTROL,down, resizeactive,0 50"
        "${modifier}CONTROL,h,    resizeactive,-50 0"
        "${modifier}CONTROL,l,    resizeactive,50 0"
        "${modifier}CONTROL,k,    resizeactive,0 -50"
        "${modifier}CONTROL,j,    resizeactive,0 50"

        # ── Focus Movement ─────────────────────────────────────────────────────
        "${modifier},left, movefocus,l"
        "${modifier},right,movefocus,r"
        "${modifier},up,   movefocus,u"
        "${modifier},down, movefocus,d"
        "${modifier},h,    movefocus,l"
        "${modifier},k,    movefocus,u"
        "${modifier},j,    movefocus,d"
        "${modifier},l,    movefocus,r"

        # ── Workspaces ─────────────────────────────────────────────────────────
        "${modifier},1,workspace,1"
        "${modifier},2,workspace,2"
        "${modifier},3,workspace,3"
        "${modifier},4,workspace,4"
        "${modifier},5,workspace,5"
        "${modifier},6,workspace,6"
        "${modifier},7,workspace,7"
        "${modifier},8,workspace,8"
        "${modifier},9,workspace,9"
        "${modifier},0,workspace,10"

        "${modifier}SHIFT,1,movetoworkspace,1"
        "${modifier}SHIFT,2,movetoworkspace,2"
        "${modifier}SHIFT,3,movetoworkspace,3"
        "${modifier}SHIFT,4,movetoworkspace,4"
        "${modifier}SHIFT,5,movetoworkspace,5"
        "${modifier}SHIFT,6,movetoworkspace,6"
        "${modifier}SHIFT,7,movetoworkspace,7"
        "${modifier}SHIFT,8,movetoworkspace,8"
        "${modifier}SHIFT,9,movetoworkspace,9"
        "${modifier}SHIFT,0,movetoworkspace,10"

        # Special workspace (scratchpad)
        "${modifier}SHIFT,SPACE,movetoworkspace,special"
        "${modifier},SPACE,togglespecialworkspace"

        # Workspace navigation
        "${modifier}CONTROL,right,workspace,e+1"
        "${modifier}CONTROL,left, workspace,e-1"
        "${modifier},mouse_down,workspace,e+1"
        "${modifier},mouse_up,  workspace,e-1"

        # ── Mouse Bindings ─────────────────────────────────────────────────────
        "${modifier},mouse:274,togglefloating"

        # ── Grouping ───────────────────────────────────────────────────────────
        "${modifier},G,togglegroup"
        "ALT,Tab,changegroupactive"
        "${modifier}ALT,Tab,cyclenext,prev"

        # ── Quick Actions ──────────────────────────────────────────────────────
        "${modifier}ALT,L,exec,swaylock"
        "${modifier}ALT,R,exec,hyprctl reload"
        "${modifier}ALT,K,exec,hyprctl kill"
        "CTRLALT,Delete,exec,wlogout"
      ];

      bindm = [
        "${modifier},mouse:272,movewindow"
        "${modifier},mouse:273,resizewindow"
      ];

      # ── Media Keys ─────────────────────────────────────────────────────────
      bindel = [
        ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
        ",XF86MonBrightnessUp,  exec,brightnessctl set +5%"
      ];
      bindl = [
        ",XF86AudioMute,        exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay,        exec,playerctl play-pause"
        ",XF86AudioPause,       exec,playerctl play-pause"
        ",XF86AudioNext,        exec,playerctl next"
        ",XF86AudioPrev,        exec,playerctl previous"
      ];
    };
  };
}
