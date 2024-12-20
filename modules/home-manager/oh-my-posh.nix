{ pkgs, ... }: {
  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    useTheme = "quick-term";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
