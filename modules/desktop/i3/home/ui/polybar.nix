{ pkgs, config, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar;
    script = "polybar main &";
    config = {
      "bar/main" = {
        width = "99%";
        height = "35px";
        radius = "16.0";
        fixed-center = true;
        background = "#D9${config.stylix.base16Scheme.base00}";
        foreground = "#${config.stylix.base16Scheme.base05}";
        line-size = "2px";
        padding-left = "2";
        padding-right = "2";
        module-margin-left = "1";
        module-margin-right = "1";
        font-0 = "JetBrainsMono Nerd Font Mono:size=10;2";
        modules-left = "i3 xwindow";
        modules-center = "date";
        modules-right = "pulseaudio battery network cpu memory";
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

      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:30:...%";
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

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0"; # or BAT1, etc.
        adapter = "ADP1"; # or ACAD, etc.
        full-at = 98;
        format-charging = "<animation-charging> <label-charging>";
        format-discharging = "<ramp-capacity> <label-discharging>";
        format-full = "<ramp-capacity> <label-full>";
        label-charging = "%percentage%%";
        label-discharging = "%percentage%%";
        label-full = "Full";
        ramp-capacity-0 = "";
        ramp-capacity-1 = "";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";
        animation-charging-framerate = 750;
      };

      "module/network" = {
        type = "internal/network";
        # You may need to change the interface name.
        # Use `ip addr` to find your network interface.
        interface = "wlp0s20f3"; # Example: wlan0, eth0, etc.
        interval = 3;
        format-connected = "<label-connected>";
        label-connected = " %essid% (%downspeed%)";
        format-disconnected = "<label-disconnected>";
        label-disconnected = " Disconnected";
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