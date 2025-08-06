{ pkgs, ... }:

{
  systemd.user.services.xautolock = {
    Unit = {
      Description = "Automatic screen locker";
      After = [ "graphical-session-pre.target" ];
    };
    Service = {
      ExecStart = ''
        ${pkgs.xautolock}/bin/xautolock \
          -time 10 \
          -locker "${pkgs.betterlockscreen}/bin/betterlockscreen -l" \
          -killer "xset dpms force off" \
          -killtime 15
      '';
      Restart = "on-failure";
      RestartSec = "10";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
