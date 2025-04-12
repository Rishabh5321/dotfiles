{ pkgs, ... }: {
  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    useTheme = "agnoster";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
