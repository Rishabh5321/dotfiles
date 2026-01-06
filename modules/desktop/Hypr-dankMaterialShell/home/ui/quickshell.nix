{ inputs
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
      # Add any other settings here
    };
  };
}
