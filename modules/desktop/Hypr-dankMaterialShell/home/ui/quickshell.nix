{ inputs
, ...
}:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
  ];

  programs.dankMaterialShell = {
    enable = true;
    systemd.enable = true;

    default.settings = {
      theme = "dark";
      dynamicTheming = true;
      # Add any other settings here
    };
  };
}
