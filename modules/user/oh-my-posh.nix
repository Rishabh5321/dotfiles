{ pkgs, ... }:
{
  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    useTheme = "onehalf.minimal";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
