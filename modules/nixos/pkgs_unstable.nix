{ pkgs-unstable, inputs, ... }: {
  environment.systemPackages = with pkgs-unstable; [
    gamescope
    stremio
    vscode
    winetricks
    zed-editor
    heroic
    lutris
    mangohud
    protonup-qt
  ];
}
