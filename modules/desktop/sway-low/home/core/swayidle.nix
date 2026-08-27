{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    systemdTargets = [ "sway-session.target" ];
    events = {
      before-sleep = "${pkgs.systemd}/bin/loginctl lock-session";
      lock = "${pkgs.swaylock}/bin/swaylock -f";
    };
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
      {
        timeout = 300;
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
    ];
  };
}
