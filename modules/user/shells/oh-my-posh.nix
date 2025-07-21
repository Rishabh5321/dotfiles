{ pkgs, ... }:
{
  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    useTheme = "emodipt-extend";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
