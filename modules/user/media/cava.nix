{ config, ... }: {
  programs.cava = {
    enable = true;
    settings = {
      general = {
        bar_spacing = 1;
        bar_width = 2;
        frame_rate = 60;
      };
      color = {
        #gradient = 1;
        #gradient_color_1 = "'#011f30'";
        #gradient_color_2 = "'#09465b'";
        #gradient_color_3 = "'#045a93'";
        #gradient_color_4 = "'#00aa00'";
        #gradient_color_5 = "'#ffff00'";
        #gradient_color_6 = "'#cc8033'";
        #gradient_color_7 = "'#aa0000'";
        #gradient_color_8 = "'#ff00ff'";
        # Old config
        #gradient = 1;
        #gradient_color_1 = "'#8bd5ca'";
        #gradient_color_2 = "'#91d7e3'";
        #gradient_color_3 = "'#7dc4e4'";
        #gradient_color_4 = "'#8aadf4'";
        #gradient_color_5 = "'#c6a0f6'";
        #gradient_color_6 = "'#f5bde6'";
        #gradient_color_7 = "'#ee99a0'";
        #gradient_color_8 = "'#ed8796'";
        # Dracula
        gradient = 1;
        gradient_color_1 = "'#8BE9FD'";
        gradient_color_2 = "'#9AEDFE'";
        gradient_color_3 = "'#CAA9FA'";
        gradient_color_4 = "'#BD93F9'";
        gradient_color_5 = "'#FF92D0'";
        gradient_color_6 = "'#FF79C6'";
        gradient_color_7 = "'#FF6E67'";
        gradient_color_8 = "'#FF5555'";
      };
    };
  };
}
