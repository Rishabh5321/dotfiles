{ pkgs, ... }:
{
  services.picom = {
    enable = true;
    package = pkgs.picom;
    settings = {
      # Animations
      transition-length = 300;
      transition-pow-x = 0.1;
      transition-pow-y = 0.1;
      transition-pow-w = 0.1;
      transition-pow-h = 0.1;
      size-transition = true;

      # Shadows
      shadow = true;
      shadow-radius = 12;
      shadow-offset-x = -12;
      shadow-offset-y = -12;
      shadow-opacity = 0.75;
      shadow-exclude = [
        "name = 'Notification'"
        "class_g = 'Conky'"
        "class_g ?= 'Notify-osd'"
        "class_g = 'Cairo-clock'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      # Fading
      fading = true;
      fade-delta = 4;
      fade-in-step = 0.03;
      fade-out-step = 0.03;
      no-fading-openclose = true;
      no-fading-destroyed-argb = true;

      # Blur
      blur-background = true;
      blur-method = "dual_kawase";
      blur-strength = 7;
      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      # General
      backend = "glx";
      vsync = true;
      dbus = false;
      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      glx-no-stencil = true;
      use-damage = true;
      log-level = "warn";
      wintypes = {
        tooltip = { fade = true; shadow = true; opacity = 0.75; focus = true; };
      };
    };
  };
}
