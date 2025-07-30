{ pkgs, ... }:
{
  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    useTheme = "markbull";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
