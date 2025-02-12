_:

{
  systemd.user.services.seanime = {
    enable = true;
    description = "Seanime Web Application";
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];

    serviceConfig = {
      ExecStart = "%h/Seanime/seanime";
      WorkingDirectory = "%h/Seanime";
      Restart = "always";
      RestartSec = "5s";

      # Ensure mpv can access Wayland/X11
      Environment = [
        "DISPLAY=:0"
        "WAYLAND_DISPLAY=wayland-0"
        "XDG_RUNTIME_DIR=/run/user/1000"
        "PATH=/run/wrappers/bin:/home/rishabh/.nix-profile/bin:/etc/profiles/per-user/rishabh/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
      ];
    };
  };

}
