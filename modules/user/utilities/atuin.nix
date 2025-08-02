_: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      search_mode = "fuzzy";
      #inline_height = 10;
      show_preview = true;
      update_check = false;
      show_help = true;
      style = "compact";
      inline_height = 10;
      sync = {
        records = true;
      };
      auto_sync = true;
      sync_frequency = "1h";
    };
  };
}
