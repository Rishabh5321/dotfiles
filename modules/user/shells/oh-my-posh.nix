{ pkgs, ... }:
{
  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    useTheme = "ys";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
