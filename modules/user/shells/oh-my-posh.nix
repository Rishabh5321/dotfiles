{ pkgs, ... }:
{
  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    useTheme = "clean-detailed";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
