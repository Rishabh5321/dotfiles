{ ... }: {
  # ...other config, other config...

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    bash.enable = true;
    zsh.enable = true;
  };
}
