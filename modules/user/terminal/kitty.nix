_:
{
  programs.kitty = {
    enable = true;
    settings = {
      # Disable popup confirmation window when closing Kitty terminal
      confirm_os_window_close = 0;

      # Cursor
      cursor_shape = "beam";
      cursor_beam_thickness = "1.0";
      cursor_blink_interval = "0";
      cursor_trail = "3";
      cursor_trail_decay = "0.1 0.6";
      cursor_trail_start_threshold = "1";

      # Performance tuning
      sync_to_monitor = true;

      # Number of lines of history to keep in memory for scrolling back
      scrollback_lines = 1000;

      # Tab bar position, style and alignment
      # tab_bar_edge = "top";
      # tab_bar_min_tabs = "1";
      # tab_bar_style = "powerline";
      # tab_powerline_style = "slanted";
      # tab_bar_align = "left";
      #
      window_padding_width = 5;
      tab_bar_margin_width = 5;

      # When the current tab is closed, go back to the previous tab
      tab_switch_strategy = "previous";

      # Tab bar title
      tab_title_max_length = "0";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}";

      # Active/Inactive tab style
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";

      # Terminal bell
      enable_audio_bell = false;
      window_alert_on_bell = true;

      # URLs
      detect_urls = true;
      url_prefixes = "file ftp ftps gemini git gopher http https irc ircs kitty mailto news sftp ssh";
      underline_hyperlinks = "always";
      url_style = "curly";
      open_url_with = "default";

      # Terminal Colors
      term = "xterm-256color";

      # Emoji Fallback
      symbol_map = "U+1F300-U+1F5FF,U+1F600-U+1F64F,U+1F680-U+1F6FF,U+1F700-U+1F77F,U+1F780-U+1F7FF,U+1F800-U+1F8FF,U+1F900-U+1F9FF,U+2600-U+26FF,U+2700-U+27BF Noto Color Emoji";
    };
  };
}
