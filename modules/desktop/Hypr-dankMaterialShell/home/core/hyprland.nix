{ lib
, pkgs
, config
, ...
}:

let
  inherit (import ../misc/variables.nix) browser terminal extraMonitorSettings;
  modifier = "SUPER";
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

  # ── Lua emission helpers ──────────────────────────────────────────────
  # Home Manager turns every settings attribute into an `hl.<name>(...)`
  # call, so we build raw Lua expressions here and hand them over.

  lua = lib.generators.mkLuaInline;
  toLua = lib.generators.toLua { };

  # Parse a decimal literal straight into a Nix number (no rounding).
  toNum = builtins.fromJSON;

  # Like `toNum`, but keeps non-numeric keywords such as "auto" as strings.
  toNumOr = v: if lib.match "-?[0-9]+(\\.[0-9]+)?" v == null then v else toNum v;

  # `hl.dsp.<path>(<table>)`. Pass `null` for dispatchers that take no args.
  dsp =
    path: args:
    if args == null then lua "hl.dsp.${path}()" else lua "hl.dsp.${path}(${toLua args})";

  exec = cmd: lua "hl.dsp.exec_cmd(${toLua cmd})";

  # `hl.bind(<key>, <dispatcher>[, <flags>])`
  bind =
    key: dispatcher: flags:
    { _args = [ key dispatcher ] ++ lib.optional (flags != { }) flags; };

  # Key spec built from the main modifier, e.g. k [ "SHIFT" ] "W" -> MOD .. " + SHIFT + W"
  k = extraMods: name: lua ''MOD .. " + ${lib.concatStringsSep " + " (extraMods ++ [ name ])}"'';

  # Key spec without the main modifier, e.g. plain "ALT + space"
  plain = spec: lua (toLua spec);

  # `hl.monitor({ output, mode, position, scale, transform })` from a
  # hyprlang-style "name,modes,position,scale,transform" string.
  mkMonitor =
    spec:
    let
      parts = map lib.trim (lib.splitString "," spec);
      count = lib.length parts;
      at = i: if i < count then lib.elemAt parts i else null;
    in
    {
      _args = [
        (lib.filterAttrs (_: v: v != null) {
          output = lib.head parts;
          mode = at 1;
          position = at 2;
          scale = if count > 3 then toNumOr (at 3) else null;
          transform = if count > 4 then lib.toInt (at 4) else null;
        })
      ];
    };

  # `hl.env("NAME", "VALUE")` from a hyprlang-style "NAME,VALUE" string.
  mkEnv =
    spec:
    let
      parts = map lib.trim (lib.splitString "," spec);
    in
    { _args = [ (lib.head parts) (lib.concatStringsSep "," (lib.tail parts)) ]; };

  # `hl.curve("name", { type = "bezier", points = { {x1, y1}, {x2, y2} } })`
  # from a hyprlang-style "name, x1, y1, x2, y2" string.
  mkCurve =
    spec:
    let
      parts = map lib.trim (lib.splitString "," spec);
      num = i: toNum (lib.elemAt parts i);
    in
    {
      _args = [
        (lib.head parts)
        {
          type = "bezier";
          points = [
            [ (num 1) (num 2) ]
            [ (num 3) (num 4) ]
          ];
        }
      ];
    };

  # `hl.animation({ leaf, enabled, speed, bezier })` from a hyprlang-style
  # "name, speed, length, bezier" string. `length` is unused in lua configs.
  mkAnimation =
    spec:
    let
      parts = map lib.trim (lib.splitString "," spec);
    in
    {
      _args = [
        {
          leaf = lib.head parts;
          enabled = true;
          speed = toNum (lib.elemAt parts 1);
          bezier = lib.elemAt parts 3;
        }
      ];
    };

  # `hl.gesture({ fingers, direction, action })` from hyprlang-style
  # "fingers, direction, action".
  mkGesture =
    spec:
    let
      parts = map lib.trim (lib.splitString "," spec);
    in
    {
      _args = [
        {
          fingers = lib.toInt (lib.head parts);
          direction = lib.elemAt parts 1;
          action = lib.elemAt parts 2;
        }
      ];
    };

  # hyprlang "rgb(A) rgb(B) 45deg" -> { colors = [ "rgb(A)" "rgb(B)" ]; angle = 45; }
  mkGradient =
    spec:
    let
      parts = lib.filter (s: s != "") (lib.splitString " " spec);
      # the angle is always the trailing "...deg" term
      angle = lib.removeSuffix "deg" (lib.last parts);
    in
    {
      colors = lib.init parts;
      angle = toNum angle;
    };

  startupCommands = [
    "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "systemctl --user restart xdg-desktop-portal 2>/dev/null || true"
    "swaync # Start notification daemon"
    "systemctl --user start hyprpolkitagent"
    "kdeconnect-indicator # Start kdeconnect indicator earlier"
    "wl-paste --type text --watch cliphist store"
    "wl-paste --type image --watch cliphist store"
    "sleep 5 && dms ipc call lock lock"
  ];

  monitorList =
    [ (mkMonitor "eDP-1,1920x1080@60,0x0,1") ]
    ++ map mkMonitor (
      lib.filter (s: lib.trim s != "") (lib.splitString "\n" extraMonitorSettings)
    );
in
with lib;
{
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    configType = "lua";
    portalPackage =
      pkgs.xdg-desktop-portal-hyprland;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };
    settings = {
      # ── Locals ────────────────────────────────────────────────────────────
      # Emits `local MOD = "SUPER"`, referenced by every MOD keybind below.
      MOD._var = modifier;

      # ── Environment ───────────────────────────────────────────────────────
      env = map mkEnv [
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland, x11"
        "CLUTTER_BACKEND, wayland"
        "QT_QPA_PLATFORM,wayland;xcb"
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
      # hyprlang's `exec-once` has no lua equivalent, use the start event.
      on = {
        _args = [
          "hyprland.start"
          (lua "function()\n${lib.concatStrings (map (c: "  hl.exec_cmd(${toLua c})\n") startupCommands)}end")
        ];
      };

      # ── Monitor Setup ─────────────────────────────────────────────────────
      monitor = monitorList;

      # ── General Settings ──────────────────────────────────────────────────
      config = {
        _args = [
          {
            general = {
              gaps_in = 2;
              gaps_out = 4;
              border_size = 2;
              layout = "dwindle";
              resize_on_border = true;
              extend_border_grab_area = 15;
              hover_icon_on_border = true;
              allow_tearing = false;
              col = lib.optionalAttrs stylixEnabled {
                active_border = mkGradient "rgb(${palette.base0D}) rgb(${palette.base0B}) 45deg";
                inactive_border = "rgb(${palette.base00})";
              };
            };

            render = {
              direct_scanout = true;
            };

            cursor = {
              no_hardware_cursors = false;
              enable_hyprcursor = true;
            };

            # ── Input Settings ───────────────────────────────────────────────
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
                tap_to_click = true;
                tap_and_drag = true;
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
              vrr = 1;
              enable_swallow = true;
              swallow_regex = "^(kitty|alacritty|foot|ghostty)$";
              swallow_exception_regex = "^(wev)$";
            };

            animations.enabled = true;

            # ── Decoration ───────────────────────────────────────────────────
            decoration = {
              rounding = 4;

              dim_inactive = false;
              dim_strength = 0.1;
              dim_special = 0.8;

              blur = {
                new_optimizations = true;
              };
            };

            # ── Layout Settings ──────────────────────────────────────────────
            dwindle = {
              # pseudotile = true;
              preserve_split = true;
              smart_split = false;
              smart_resizing = true;
              permanent_direction_override = false;
              special_scale_factor = 1.0;
              split_width_multiplier = 1.0;
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
          }
        ];
      };

      # ── Snappier Animations ───────────────────────────────────────────────
      curve = map mkCurve [
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

      animation = map mkAnimation [
        "windowsIn, 1, 3, default"
        "windowsOut, 1, 3, default"
        "workspaces, 1, 5, default"
        "windowsMove, 1, 4, default"
        "fade, 1, 3, default"
        "border, 1, 3, default"
      ];

      # ── Gestures ──────────────────────────────────────────────────────────
      gesture = mkGesture "3, horizontal, workspace";

      # ── Keybindings ────────────────────────────────────────────────────────
      bind = [
        # Application launchers
        (bind (k [ ] "Return") (exec terminal) { })
        (bind (plain "ALT + space") (exec "dms ipc call spotlight toggle") { })
        (bind (k [ ] "V") (exec "dms ipc call clipboard toggle") { })
        (bind (k [ "ALT" ] "W") (exec "wallSelector") { })
        (bind (k [ ] "W") (exec browser) { })
        (bind (plain "CTRL + L") (exec "dms ipc call lock lock") { })
        (bind (k [ ] "E") (exec "dms ipc call spotlight toggleQuery ':'") { })
        (bind (k [ "SHIFT" ] "S") (exec "grim -g \"$(slurp)\" - | swappy -f -") { })
        (bind (k [ ] "D") (exec "discord") { })
        (bind (k [ ] "C") (exec "hyprpicker -a") { })
        (bind (k [ ] "T") (exec "thunar") { })
        (bind (k [ ] "M") (exec "spotify") { })
        (bind (k [ ] "N") (exec "swaync-client -t -sw") { })

        # Window management
        (bind (k [ ] "Q") (dsp "window.kill" null) { })
        (bind (k [ ] "P") (dsp "window.pseudo" null) { })
        # (bind (k [ "SHIFT" ] "I") (dsp "layout" ...) { })
        (bind (k [ ] "F") (dsp "window.fullscreen" null) { })
        (bind (k [ "SHIFT" ] "F") (dsp "window.float" { action = "toggle"; }) { })
        (bind (k [ "SHIFT" ] "C") (dsp "exit" null) { })
        (bind (k [ "SHIFT" ] "P") (dsp "window.pin" { action = "toggle"; }) { })

        # Wall integration
        (bind (k [ "SHIFT" ] "W") (exec "skwd wall toggle") { })

        # ── Enhanced Window Movement ───────────────────────────────────────────
        (bind (k [ "SHIFT" ] "left") (dsp "window.move" { direction = "left"; }) { })
        (bind (k [ "SHIFT" ] "right") (dsp "window.move" { direction = "right"; }) { })
        (bind (k [ "SHIFT" ] "up") (dsp "window.move" { direction = "up"; }) { })
        (bind (k [ "SHIFT" ] "down") (dsp "window.move" { direction = "down"; }) { })
        (bind (k [ "SHIFT" ] "h") (dsp "window.move" { direction = "left"; }) { })
        (bind (k [ "SHIFT" ] "l") (dsp "window.move" { direction = "right"; }) { })
        (bind (k [ "SHIFT" ] "k") (dsp "window.move" { direction = "up"; }) { })
        (bind (k [ "SHIFT" ] "j") (dsp "window.move" { direction = "down"; }) { })

        # Resize windows
        (bind (k [ "CTRL" ] "left") (dsp "window.resize" { x = -50; y = 0; relative = true; }) { })
        (bind (k [ "CTRL" ] "right") (dsp "window.resize" { x = 50; y = 0; relative = true; }) { })
        (bind (k [ "CTRL" ] "up") (dsp "window.resize" { x = 0; y = -50; relative = true; }) { })
        (bind (k [ "CTRL" ] "down") (dsp "window.resize" { x = 0; y = 50; relative = true; }) { })
        (bind (k [ "CTRL" ] "h") (dsp "window.resize" { x = -50; y = 0; relative = true; }) { })
        (bind (k [ "CTRL" ] "l") (dsp "window.resize" { x = 50; y = 0; relative = true; }) { })
        (bind (k [ "CTRL" ] "k") (dsp "window.resize" { x = 0; y = -50; relative = true; }) { })
        (bind (k [ "CTRL" ] "j") (dsp "window.resize" { x = 0; y = 50; relative = true; }) { })

        # ── Focus Movement ─────────────────────────────────────────────────────
        (bind (k [ ] "left") (dsp "focus" { direction = "left"; }) { })
        (bind (k [ ] "right") (dsp "focus" { direction = "right"; }) { })
        (bind (k [ ] "up") (dsp "focus" { direction = "up"; }) { })
        (bind (k [ ] "down") (dsp "focus" { direction = "down"; }) { })
        (bind (k [ ] "h") (dsp "focus" { direction = "left"; }) { })
        (bind (k [ ] "k") (dsp "focus" { direction = "up"; }) { })
        (bind (k [ ] "j") (dsp "focus" { direction = "down"; }) { })
        (bind (k [ ] "l") (dsp "focus" { direction = "right"; }) { })

        # ── Workspaces ─────────────────────────────────────────────────────────
        (bind (k [ ] "1") (dsp "focus" { workspace = 1; }) { })
        (bind (k [ ] "2") (dsp "focus" { workspace = 2; }) { })
        (bind (k [ ] "3") (dsp "focus" { workspace = 3; }) { })
        (bind (k [ ] "4") (dsp "focus" { workspace = 4; }) { })
        (bind (k [ ] "5") (dsp "focus" { workspace = 5; }) { })
        (bind (k [ ] "6") (dsp "focus" { workspace = 6; }) { })
        (bind (k [ ] "7") (dsp "focus" { workspace = 7; }) { })
        (bind (k [ ] "8") (dsp "focus" { workspace = 8; }) { })
        (bind (k [ ] "9") (dsp "focus" { workspace = 9; }) { })
        (bind (k [ ] "0") (dsp "focus" { workspace = 10; }) { })

        (bind (k [ "SHIFT" ] "1") (dsp "window.move" { workspace = 1; }) { })
        (bind (k [ "SHIFT" ] "2") (dsp "window.move" { workspace = 2; }) { })
        (bind (k [ "SHIFT" ] "3") (dsp "window.move" { workspace = 3; }) { })
        (bind (k [ "SHIFT" ] "4") (dsp "window.move" { workspace = 4; }) { })
        (bind (k [ "SHIFT" ] "5") (dsp "window.move" { workspace = 5; }) { })
        (bind (k [ "SHIFT" ] "6") (dsp "window.move" { workspace = 6; }) { })
        (bind (k [ "SHIFT" ] "7") (dsp "window.move" { workspace = 7; }) { })
        (bind (k [ "SHIFT" ] "8") (dsp "window.move" { workspace = 8; }) { })
        (bind (k [ "SHIFT" ] "9") (dsp "window.move" { workspace = 9; }) { })
        (bind (k [ "SHIFT" ] "0") (dsp "window.move" { workspace = 10; }) { })

        # Special workspace (scratchpad)
        (bind (k [ "SHIFT" ] "space") (dsp "window.move" { workspace = "special"; }) { })
        (bind (k [ ] "space") (lua ''hl.dsp.workspace.toggle_special("special")'') { })

        # Workspace navigation
        (bind (k [ "CTRL" ] "right") (dsp "focus" { workspace = "e+1"; }) { })
        (bind (k [ "CTRL" ] "left") (dsp "focus" { workspace = "e-1"; }) { })
        (bind (k [ ] "mouse_down") (dsp "focus" { workspace = "e+1"; }) { })
        (bind (k [ ] "mouse_up") (dsp "focus" { workspace = "e-1"; }) { })

        # ── Mouse Bindings ─────────────────────────────────────────────────────
        (bind (k [ ] "mouse:274") (dsp "window.float" null) { })

        # ── Grouping ───────────────────────────────────────────────────────────
        (bind (k [ ] "G") (dsp "group.toggle" null) { })
        (bind (plain "ALT + Tab") (dsp "group.next" null) { })
        (bind (k [ "ALT" ] "Tab") (dsp "group.prev" null) { })

        # ── Quick Actions ──────────────────────────────────────────────────────
        (bind (k [ "ALT" ] "L") (exec "swaylock") { })
        (bind (k [ "ALT" ] "R") (exec "hyprctl reload") { })
        (bind (k [ "ALT" ] "K") (exec "hyprctl kill") { })
        (bind (plain "CTRL + ALT + Delete") (exec "wlogout") { })

        # ── Interactive drag / resize (hyprland's `bindm`) ─────────────────────
        (bind (k [ ] "mouse:272") (dsp "window.drag" null) { mouse = true; })
        (bind (k [ ] "mouse:273") (dsp "window.resize" null) { mouse = true; })

        # ── Media Keys ─────────────────────────────────────────────────────────
        (bind
          (plain "XF86AudioRaiseVolume")
          (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
          {
            locked = true;
            repeating = true;
          })
        (bind
          (plain "XF86AudioLowerVolume")
          (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
          {
            locked = true;
            repeating = true;
          })
        (bind
          (plain "XF86MonBrightnessDown")
          (exec "brightnessctl set 5%-")
          {
            locked = true;
            repeating = true;
          })
        (bind
          (plain "XF86MonBrightnessUp")
          (exec "brightnessctl set +5%")
          {
            locked = true;
            repeating = true;
          })
        (bind (plain "XF86AudioMute") (exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") { locked = true; })
        (bind (plain "XF86AudioPlay") (exec "playerctl play-pause") { locked = true; })
        (bind (plain "XF86AudioPause") (exec "playerctl play-pause") { locked = true; })
        (bind (plain "XF86AudioNext") (exec "playerctl next") { locked = true; })
        (bind (plain "XF86AudioPrev") (exec "playerctl previous") { locked = true; })
      ];
    };
  };
}
