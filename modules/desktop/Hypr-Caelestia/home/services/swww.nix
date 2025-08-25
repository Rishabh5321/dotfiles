{ pkgs, ... }: {
  services.swww = {
    enable = true;
    package = pkgs.swww;
  };
}
