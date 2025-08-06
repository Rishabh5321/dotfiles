{ pkgs, wallpaper, wallpapers, ... }:

{
  home.file.".config/betterlockscreenrc".text = ''
    wall_fill="fill"
    wall_gravity="center"
    fx_blur="0.5"
    fx_dim="0.2"
  '';

  systemd.user.services.betterlockscreen = {
    Unit = {
      Description = "Update betterlockscreen wallpaper cache";
      After = [ "graphical-session-pre.target" ];
    };
    Service = {
      ExecStart = "${pkgs.betterlockscreen}/bin/betterlockscreen -u '${wallpapers}/${wallpaper}'";
      Type = "oneshot";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
