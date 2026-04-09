{ pkgs, ... }: {
  services.awww = {
    enable = true;
    package = pkgs.awww;
  };
}
