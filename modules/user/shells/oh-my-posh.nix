{ pkgs, ... }:
{
  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    useTheme = "catppuccin";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
