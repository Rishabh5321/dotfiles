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
    };
  };
}
