{ pkgs, ... }: {
  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    useTheme = "mojada";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
