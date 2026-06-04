{ pkgs
, config
, inputs
, lib
, ...
}:

let
  inherit (import ../misc/variables.nix) browser terminal;
  modifier = "Mod";
  stylixEnabled = if config ? stylix then config.stylix.enable else false;
in
{
  imports = [
    inputs.niri.homeModules.niri
  ];

  programs.niri = {
    package = inputs.niri.packages.${pkgs.system}.niri-unstable;
    settings = {
      input = {
        keyboard.xkb.layout = "us";
        touchpad = {
          tap = true;
          natural-scroll = true;
        };
        mouse.natural-scroll = true;
      };

      outputs = {
        "eDP-1" = {
          mode = { width = 1920; height = 1080; refresh = 60.0; };
          scale = 1.0;
        };
      };

      layout = {
        gaps = 8;
        center-focused-column = "never";
        preset-column-widths = [
          { proportion = 1.0 / 3.0; }
          { proportion = 1.0 / 2.0; }
          { proportion = 2.0 / 3.0; }
        ];
        default-column-width.proportion = 1.0;
        border = {
          width = 2;
          active = if stylixEnabled then "#${config.stylix.base16Scheme.base0D}" else "#ffffff";
          inactive = if stylixEnabled then "#${config.stylix.base16Scheme.base00}" else "#000000";
        };
        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };
      };

      spawn-at-startup = [
        { command = [ "${pkgs.waybar}/bin/waybar" ]; }
        { command = [ "${pkgs.swaynotificationcenter}/bin/swaync" ]; }
      ] ++ lib.optional stylixEnabled { command = [ "${pkgs.swaybg}/bin/swaybg" "-i" config.stylix.image ]; };

      binds = {
        "Mod+Return".action.spawn = [ terminal ];
        "Mod+D".action.spawn = [ "rofi" "-show" "drun" ];
        "Mod+Q".action.close-window = { };
        "Mod+Left".action.focus-column-left = { };
        "Mod+Right".action.focus-column-right = { };
        "Mod+Up".action.focus-window-up = { };
        "Mod+Down".action.focus-window-down = { };
        "Mod+Shift+Left".action.move-column-left = { };
        "Mod+Shift+Right".action.move-column-right = { };
        "Mod+F".action.maximize-column = { };
        "Mod+Shift+F".action.fullscreen-window = { };
        "Mod+C".action.center-column = { };
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";
        "Mod+V".action.spawn = [ "cliphist" "list" "|" "rofi" "-dmenu" "|" "cliphist" "decode" "|" "wl-copy" ];
        "Mod+Shift+E".action.quit = { };
        "Mod+Shift+P".action.spawn = [ "swaylock" ];

        "XF86AudioRaiseVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" ];
        "XF86AudioLowerVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" ];
        "XF86AudioMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
        "XF86AudioPlay".action.spawn = [ "playerctl" "play-pause" ];
        "XF86AudioNext".action.spawn = [ "playerctl" "next" ];
        "XF86AudioPrev".action.spawn = [ "playerctl" "previous" ];
        "XF86MonBrightnessUp".action.spawn = [ "brightnessctl" "set" "+5%" ];
        "XF86MonBrightnessDown".action.spawn = [ "brightnessctl" "set" "5%-" ];
      };
    };
  };
}
