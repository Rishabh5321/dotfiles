{
  programs.i3status = {
    enable = false; # Disable i3status
  };

  services.i3blocks = {
    enable = true;
    bars = [{
      statusCommand = "i3blocks";
      trayOutput = "primary";
    }];
    config = {
      "time" = {
        command = "date '+%a %d %b %H:%M'";
        interval = 60;
        color = "#FFFFFF";
      };

      "cpu_usage" = {
        command = "top -bn1 | grep 'Cpu(s)' | awk '{print \"CPU: \" 100 - $8 \"%\"}'";
        interval = 10;
      };

      "memory" = {
        command = "free -h | awk '/Mem:/ { print \"RAM: \"$3\"/\"$2 }'";
        interval = 20;
      };

      "disk" = {
        command = "df -h / | awk 'NR==2 {print \"Disk: \"$3\"/\"$2}'";
        interval = 60;
      };

      "battery" = {
        command = "acpi | cut -d, -f2-";
        interval = 30;
      };

      "volume" = {
        command = "pamixer --get-volume-human";
        interval = 5;
      };

      "network" = {
        command = "ip -4 -o addr show up primary | awk '{print $4}' | cut -d/ -f1";
        interval = 30;
      };
    };
  };
}
