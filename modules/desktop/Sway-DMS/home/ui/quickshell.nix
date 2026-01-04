{ inputs
, pkgs
, ...
}:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dank-material-shell
  ];

  systemd.user.services.dms = {
    Unit = {
      Description = "DankMaterialShell";
      After = [ "graphical-session.target" ];
    };
    Service = {
      # This adds the quickshell binary to the service's PATH
      Environment = "PATH=${pkgs.lib.makeBinPath [ pkgs.quickshell ]}:/run/current-system/sw/bin:/bin";
    };
  };

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;

    default.settings = {
      theme = "dark";
      dynamicTheming = true;
      # Add any other settings here
    };
  };
}
