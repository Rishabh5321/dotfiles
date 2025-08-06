{ pkgs, ... }:

{
  services.xidlehook = {
    enable = true;
    not-when-audio = true;
    not-when-fullscreen = true;
    timers = [
      {
        delay = 600;
        command = "${pkgs.betterlockscreen}/bin/betterlockscreen -l";
      }
      {
        delay = 1500;
        command = "${pkgs.xorg.xset}/bin/xset dpms force off";
      }
    ];
  };
}
