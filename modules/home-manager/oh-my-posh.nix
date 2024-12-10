{ pkgs-unstable, ... }: {
  programs.oh-my-posh = {
    enable = true;
    package = pkgs-unstable.oh-my-posh;
    useTheme = "markbull";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
