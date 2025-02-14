{ pkgs, ... }: {
  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    useTheme = "night-owl";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
