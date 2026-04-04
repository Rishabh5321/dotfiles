{ pkgs, ... }: {
  services.swww = {
    enable = true;
    package = pkgs.awww;
  };
}
