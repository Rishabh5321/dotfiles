{ pkgs, ... }:
{
  programs.btop = {
    enable = true;

    settings = {
      theme_background = false;
      update_ms = 1000;
      rounded_corners = false;
    };
  };

  home.packages = with pkgs; [ nvtopPackages.intel ];
}
