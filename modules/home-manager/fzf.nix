_: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # colors = {
    #   "fg+" = config.stylix.base16Scheme.base00;
    #   "bg+" = "-1";
    #   "fg" = "white";
    #   "bg" = "-1";
    #   "prompt" = "grey";
    #   "pointer" = config.stylix.base16Scheme.base01;
    # };
    defaultOptions = [
      "--margin=1"
      "--layout=reverse"
      "--border=rounded"
      "--info='hidden'"
      "--header=''"
      "--prompt='/ '"
      "-i"
      "--no-bold"
    ];
  };
}