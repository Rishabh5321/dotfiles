{ pkgs, config, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar;
    script = "polybar main &";
    config = {
      "bar/main" = {
        width = "100%";
        height = "30px";
        radius = "0.0";
        fixed-center = true;
        background = "#${config.stylix.base16Scheme.base00}";
        foreground = "#${config.stylix.base16Scheme.base05}";
        line-size = "2px";
        border-bottom-size = "2px";
        border-bottom-color = "#${config.stylix.base16Scheme.base0D}";
        padding-left = "1";
        padding-right = "1";
        module-margin-left = "1";
        module-margin-right = "1";
        font-0 = "JetBrainsMono Nerd Font Mono:size=10;2";
        modules-left = "i3";
        modules-center = "date";
        modules-right = "pulseaudio cpu memory";
        tray-position = "right";
        tray-padding = "2";
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
      };

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index-sort = true;
        wrapping-scroll = false;
        label-mode-padding = "2";
        label-focused-background = "#${config.stylix.base16Scheme.base0D}";
        label-focused-underline = "#${config.stylix.base16Scheme.base0B}";
        label-focused-padding = "2";
        label-unfocused-padding = "2";
        label-visible-padding = "2";
        label-urgent-background = "#${config.stylix.base16Scheme.base08}";
        label-urgent-padding = "2";
      };

      "module/date" = {
        type = "internal/date";
        interval = "1.0";
        date = "%Y-%m-%d%";
        time = "%H:%M";
        format-prefix = " ";
        format-prefix-foreground = "#${config.stylix.base16Scheme.base0B}";
        label = "%date% %time%";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume = "<ramp-volume> <label-volume>";
        label-muted = " muted";
        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = "2";
        format-prefix = " ";
        format-prefix-foreground = "#${config.stylix.base16Scheme.base0B}";
        label = "%percentage:2%%";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = "2";
        format-prefix = " ";
        format-prefix-foreground = "#${config.stylix.base16Scheme.base0B}";
        label = "%percentage_used:2%%";
      };
    };
  };
}
