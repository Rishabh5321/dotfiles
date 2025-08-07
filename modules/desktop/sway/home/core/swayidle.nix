{
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "loginctl lock-session";
      }
      {
        event = "lock";
        command = "swaylock -f";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "swaymsg 'output * dpms off'";
        resumeCommand = "swaymsg 'output * dpms on'";
      }
      {
        timeout = 320;
        command = "loginctl lock-session";
      }
    ];
  };
}
