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
      style = "full";
      sync = {
        records = true;
      };
      auto_sync = true;
    };
  };
}
