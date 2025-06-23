{
  programs.fastfetch = {
    enable = true;

    settings = {
      display = {
        separator = " ";
      };

      modules = [
        #"break"
        #"break"
        #"break"
        {
          type = "custom";
          format = "  {#90}  {#31}  {#33}  {#33}  {#34}  {#35}  {#36}  {#37} ";
        }
        "break"
        {
          type = "custom";
          format = " {#36}   I use NixOs BTW";
        }
        {
          type = "os";
          key = "    OS";
          keyColor = "34";
        }
        {
          type = "kernel";
          key = "    Kernel";
          keyColor = "34";
        }
        {
          type = "packages";
          key = "    Packages";
          keyColor = "34";
        }
        {
          type = "display";
          key = "  󰍹  Display";
          keyColor = "34";
        }
        {
          type = "wm";
          key = "    WM";
          keyColor = "34";
        }
        {
          type = "terminal";
          key = "    Terminal";
          keyColor = "34";
        }
        {
          type = "cpu";
          format = "{1}";
          key = "    CPU";
          keyColor = "34";
        }
        {
          type = "memory";
          key = "    Memory";
          keyColor = "34";
        }
        {
          type = "cursor";
          key = "   ";
          keyColor = "34";
        }
        {
          type = "terminalfont";
          key = "   ";
          keyColor = "34";
        }
        {
          type = "uptime";
          key = "   ";
          keyColor = "34";
        }
        {
          type = "datetime";
          format = "{1}-{3}-{11}";
          key = "   ";
          keyColor = "34";
        }
        {
          type = "media";
          key = "  󰝚 ";
          keyColor = "34";
        }
        {
          type = "player";
          key = "   ";
          keyColor = "34";
        }
        "break"
        {
          type = "custom";
          format = "  {#90}  {#31}  {#33}  {#33}  {#34}  {#35}  {#36}  {#37} ";
        }
        "break"
        "break"
        "break"
      ];
    };
  };
}
