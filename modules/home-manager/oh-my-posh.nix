{ pkgs, ... }: {
  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    useTheme = "powerlevel10k_rainbow";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
