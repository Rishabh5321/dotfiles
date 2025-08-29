_: {
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
