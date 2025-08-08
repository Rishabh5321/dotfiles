{
  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        separator = " : ";
      };
      modules = [
        {
          type = "command";
          key = "  ";
          keyColor = "blue";
          text = ''splash="I use NixOS BTW";echo $splash'';
        }
        {
          type = "custom";
          format = "┌──────────────────────────────────────────┐";
        }
        {
          type = "chassis";
          key = "  󰇺 Chassis";
          format = "{1} {2} {3}";
        }
        {
          type = "os";
          key = "   OS";
          format = "{2}";
          keyColor = "red";
        }
        {
          type = "kernel";
          key = "   Kernel";
          format = "{2}";
          keyColor = "red";
        }
        {
          type = "display";
          key = "  󰍹 Display";
          format = "{1}x{2} @ {3}Hz [{7}]";
          keyColor = "green";
        }
        {
          type = "terminal";
          key = "   Terminal";
          keyColor = "yellow";
        }
        {
          type = "command";
          key = "   Shell";
          KeyColor = "yellow";
          text = ''checkshell.sh'';
        }
        {
          type = "WM";
          key = "  󱗃 WM";
          format = "{2}";
          keyColor = "yellow";
        }
        {
          type = "custom";
          format = "└──────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "┌──────────────────────────────────────────┐";
        }
        {
          type = "cpu";
          format = "{1} @ {7}";
          key = "   CPU";
          keyColor = "blue";
        }
        {
          type = "gpu";
          format = "{1} {2}";
          key = "  󰊴 GPU";
          keyColor = "blue";
        }
        {
          type = "memory";
          key = "   Memory ";
          keyColor = "magenta";
        }
        {
          type = "command";
          key = "  󱦟 OS Age ";
          keyColor = "red";
          text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        }
        {
          type = "uptime";
          key = "  󱫐 Uptime ";
          keyColor = "red";
        }
        {
          type = "custom";
          format = "└──────────────────────────────────────────┘";
        }
        {
          type = "colors";
          paddingLeft = "2";
          symbol = "circle";
        }

        "break"
      ];
    };
  };
}
