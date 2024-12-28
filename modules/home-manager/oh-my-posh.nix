{ pkgs-unstable, ... }: {
  programs.oh-my-posh = {
    enable = true;
    package = pkgs-unstable.oh-my-posh;
    useTheme = "mojada";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
