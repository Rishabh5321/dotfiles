{ pkgs, ... }: {
  # Your existing swayidle config
  services.swayidle = {
    enable = true;
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
        timeout = 310;
        command = "noctalia-shell ipc call lockScreen lock";
      }
    ];
  };

  # The fix: Add the audio idle inhibitor
  systemd.user.services.sway-audio-idle-inhibit = {
    Unit = {
      Description = "Sway audio idle inhibit";
      After = [ "graphical-session-pre.target" ];
      Partof = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.sway-audio-idle-inhibit}/bin/sway-audio-idle-inhibit";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
