{ pkgs, ... }: {
  home.packages = with pkgs; [ libnotify ];

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Moka";
      package = pkgs.moka-icon-theme;
    };
    settings = {
      global = {
        rounded = "yes";
        origin = "top-center";
        monitor = "0";
        alignment = "center";
        vertical_alignment = "center";
        width = "400";
        height = "400";
        scale = 0;
        gap_size = 0;
        progress_bar = true;
        transparency = 0;
        text_icon_padding = 0;
        #separator_color = "frame";
        sort = "yes";
        idle_threshold = 120;
        line_height = 0;
        markup = "full";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        sticky_history = "yes";
        history_length = 20;
        always_run_script = true;
        #corner_radius = config.var.theme.rounding;
        follow = "mouse";
        #font = config.var.theme.font;
        format = "<b>%s</b>\\n%b";
        #rogress_bar_corner_radius = config.var.theme.rounding - 10;
        #format = ''
        #  <span foreground='#${config.stylix.base16Scheme.accent}'><b>%s %p</b></span>
        #  %b'';
        # frame_color = "#" + config.stylix.base16Scheme.base00;
        # highlight = "#" + config.stylix.base16Scheme.base01;
        # foreground = "#" + config.stylix.base16Scheme.base04;
        frame_width = 1;
        offset = "0x10";
        horizontal_padding = 10;
        icon_position = "left";
        indicate_hidden = "yes";
        min_icon_size = 0;
        max_icon_size = 64;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_current";
        mouse_right_click = "close_all";
        padding = 10;
        plain_text = "no";
        separator_height = 2;
        show_indicators = "yes";
        shrink = "no";
        word_wrap = "yes";
        browser = "${pkgs.qutebrowser}/bin/qutebrowser";
      };

      fullscreen_delay_everything = { fullscreen = "delay"; };

      # urgency_critical = {
      #   background = "#" + config.stylix.base16Scheme.base08;
      #   foreground = "#" + config.stylix.base16Scheme.base0C;
      # };
      # urgency_low = {
      #   background = "#" + config.stylix.base16Scheme.base0D;
      #   foreground = "#" + config.stylix.base16Scheme.base0E;
      # };
      # urgency_normal = {
      #   background = "#" + config.stylix.base16Scheme.base00;
      #   foreground = "#" + config.stylix.base16Scheme.base0F;
      # };
    };
  };
}