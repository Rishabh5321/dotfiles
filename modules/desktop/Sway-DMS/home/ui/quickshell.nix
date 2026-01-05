{ inputs
, config
, lib
, ...
}:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
    settings = {
      theme = "dark";
      dynamicTheming = true;
    };
  };

  # Fix for missing environment variables in systemd service
  # specifically finding 'qs' and 'dgop' executable
  systemd.user.services.dms = {
    Service = {
      Environment = lib.mkForce "PATH=/run/current-system/sw/bin:/etc/profiles/per-user/${config.home.username}/bin:${config.home.profileDirectory}/bin:$PATH";
    };
  };
}
