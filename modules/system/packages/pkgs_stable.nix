{ pkgs-stable, ... }: {
  environment.systemPackages = with pkgs-stable; [
    # zed-editor # Editor
  ];
}
