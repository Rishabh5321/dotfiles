{ pkgs, ... }:
{
  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    useTheme = "json";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
