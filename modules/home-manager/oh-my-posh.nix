{ pkgs, ... }: {
  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    useTheme = "powerlevel10k_modern";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
