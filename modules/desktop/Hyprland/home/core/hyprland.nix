{ lib, pkgs, config, ... }:

let
  inherit (import ../misc/variables.nix) browser terminal extraMonitorSettings;
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
in
with lib; {
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    configType = "hyprlang";
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };
    settings = {
      # xwayland.enable = true;
      env = [
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland, x11"
        "CLUTTER_BACKEND, wayland"
        "QT_QPA_PLATFORM=wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "SDL_VIDEODRIVER, x11"
        "MOZ_ENABLE_WAYLAND, 1"
        # This is to make electron apps start in wayland
        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
        # Disabling this by default as it can result in inop cfg
        # Added card2 in case this gets enabled. For better coverage
        # This is mostly needed by Hybrid laptops.
        # but if you have multiple discrete GPUs this will set order
        #"AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1:/dev/card2"
        "GDK_SCALE,1"
        "QT_SCALE_FACTOR,1"
        "EDITOR,nvim"
        # Set terminal and xdg_terminal_emulator to kitty
        # To provent yazi from starting xterm when run from rofi menu
        # You can set to your preferred terminal if you you like
        # ToDo: Pull default terminal from config
        "TERMINAL,kitty"
        "XDG_TERMINAL_EMULATOR,kitty"
      ];
      # ── Startup Programs ──────────────────────────────────────────────────
      "exec-once" = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "swaync # Start notification daemon"
        "systemctl --user start hyprpolkitagent"
        "kdeconnect-indicator # Start kdeconnect indicator earlier"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        # "sleep 5 &&"
        "zen"
        "obsidian"
        "brave"
        "discord"
        "telegram-desktop"
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
        "col.active_border" = lib.mkIf stylixEnabled "rgb(${palette.base0D}) rgb(${palette.base0B}) 45deg";
        "col.inactive_border" = lib.mkIf stylixEnabled "rgb(${palette.base00})";
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

        dim_inactive = false;
        dim_strength = 0.1;
        dim_special = 0.8;
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
        orientation = "left";
        smart_resizing = true;
        drop_at_cursor = true;
      };

      # ── Keybindings ────────────────────────────────────────────────────────
      bind = [
        # Application launchers
        "SUPER,Return,exec,${terminal}"
        "ALT,SPACE,global,caelestia:launcher"
        # "SUPER,R,exec,rofi -show run"
        "SUPER,V,exec,caelestia clipboard"
        "SUPERALT,W,exec,wallSelector"
        "SUPER,W,exec,${browser}"
        "CTRL,L,global,caelestia:lock"
        # "SUPER,A,global,caelestia:session"
        "SUPER,E,exec,caelestia emoji -p"
        "SUPER,S,global,caelestia:screenshot"
        "SUPERSHIFT,S,exec,grim -g \"$(slurp)\" - | swappy -f -"
        "SUPER,D,exec,discord"
        "SUPER,C,exec,hyprpicker -a"
        "SUPER,T,exec,thunar"
        "SUPER,M,exec,spotify"
        "SUPER,N,exec,swaync-client -t -sw"

        # Window management
        "SUPER,Q,killactive,"
        "SUPER,P,pseudo,"
        "SUPERSHIFT,I,togglesplit,"
        "SUPER,F,fullscreen,"
        "SUPERSHIFT,F,togglefloating,"
        "SUPERSHIFT,C,exit,"
        "SUPERSHIFT,P,pin,"
        # "SUPERSHIFT,O,toggleopaque,"

        # Better control integration
        "SUPERSHIFT,W,exec,better-control -w"

        # ── Enhanced Window Movement ───────────────────────────────────────────
        "SUPERSHIFT,left, movewindow,l"
        "SUPERSHIFT,right,movewindow,r"
        "SUPERSHIFT,up,   movewindow,u"
        "SUPERSHIFT,down, movewindow,d"
        "SUPERSHIFT,h,    movewindow,l"
        "SUPERSHIFT,l,    movewindow,r"
        "SUPERSHIFT,k,    movewindow,u"
        "SUPERSHIFT,j,    movewindow,d"

        # Resize windows
        "SUPERCONTROL,left, resizeactive,-50 0"
        "SUPERCONTROL,right,resizeactive,50 0"
        "SUPERCONTROL,up,   resizeactive,0 -50"
        "SUPERCONTROL,down, resizeactive,0 50"
        "SUPERCONTROL,h,    resizeactive,-50 0"
        "SUPERCONTROL,l,    resizeactive,50 0"
        "SUPERCONTROL,k,    resizeactive,0 -50"
        "SUPERCONTROL,j,    resizeactive,0 50"

        # ── Focus Movement ─────────────────────────────────────────────────────
        "SUPER,left, movefocus,l"
        "SUPER,right,movefocus,r"
        "SUPER,up,   movefocus,u"
        "SUPER,down, movefocus,d"
        "SUPER,h,    movefocus,l"
        "SUPER,k,    movefocus,u"
        "SUPER,j,    movefocus,d"
        "SUPER,l,    movefocus,r"

        # ── Workspaces ─────────────────────────────────────────────────────────
        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"
        "SUPER,6,workspace,6"
        "SUPER,7,workspace,7"
        "SUPER,8,workspace,8"
        "SUPER,9,workspace,9"
        "SUPER,0,workspace,10"

        "SUPERSHIFT,1,movetoworkspace,1"
        "SUPERSHIFT,2,movetoworkspace,2"
        "SUPERSHIFT,3,movetoworkspace,3"
        "SUPERSHIFT,4,movetoworkspace,4"
        "SUPERSHIFT,5,movetoworkspace,5"
        "SUPERSHIFT,6,movetoworkspace,6"
        "SUPERSHIFT,7,movetoworkspace,7"
        "SUPERSHIFT,8,movetoworkspace,8"
        "SUPERSHIFT,9,movetoworkspace,9"
        "SUPERSHIFT,0,movetoworkspace,10"

        # Special workspace (scratchpad)
        "SUPERSHIFT,SPACE,movetoworkspace,special"
        "SUPER,SPACE,togglespecialworkspace"

        # Workspace navigation
        "SUPERCONTROL,right,workspace,e+1"
        "SUPERCONTROL,left, workspace,e-1"
        "SUPER,mouse_down,workspace,e+1"
        "SUPER,mouse_up,  workspace,e-1"

        # ── Mouse Bindings ─────────────────────────────────────────────────────
        "SUPER,mouse:274,togglefloating"

        # ── Grouping ───────────────────────────────────────────────────────────
        "SUPER,G,togglegroup"
        "ALT,Tab,changegroupactive"
        "SUPERALT,Tab,cyclenext,prev"

        # ── Quick Actions ──────────────────────────────────────────────────────
        "SUPERALT,L,exec,swaylock"
        "SUPERALT,R,exec,hyprctl reload"
        "SUPERALT,K,exec,hyprctl kill"
        "CTRLALT,Delete,exec,wlogout"
      ];

      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
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
        ",XF86AudioStop,        exec,playerctl stop"
      ];
    };
  };
}
