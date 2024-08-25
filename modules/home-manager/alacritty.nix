{lib, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding.x = 10;
        padding.y = 10;
        decorations = "none";
        startup_mode = "Windowed";
        dynamic_title = true;
        blur = true;
        opacity = 0.9;
      };
      window.dimensions = {
        columns = 160;
        lines = 80;
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
      };
      env = {
        term = "xterm-256color";
      };
      live_config_reload = true;
    };
  };
}
