{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    settings = {
      scrollback_lines = 2000;
      wheel_scroll_min_lines = 1;
      window_padding_width = 4;
      confirm_os_window_close = 0;
    };
    extraConfig = ''
      tab_bar_style fade
      tab_fade 1
      active_tab_font_style   bold
      inactive_tab_font_style bold
    '';
  };
}
