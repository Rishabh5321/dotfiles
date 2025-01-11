{ pkgs-unstable, ... }: {
  environment.systemPackages = with pkgs-unstable; [
    gamescope
    stremio
    vscode
    winetricks
    zed-editor
  ];
}
