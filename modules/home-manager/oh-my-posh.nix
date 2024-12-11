{ pkgs-unstable, ... }: {
  programs.oh-my-posh = {
    enable = true;
    package = pkgs-unstable.oh-my-posh;
    useTheme = "quick-term";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
