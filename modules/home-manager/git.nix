_: {
  # Git
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.git.enable
  # Aliases config in ./configs/git-aliases.nix
  #programs.git.enable = true;

  programs.git.extraConfig = {
    diff.colorMoved = "default";
    pull.rebase = true;
  };

  programs.git.ignores = [ "*~" ];

  programs.git.userEmail = "rishabh98818@outlook.com";
  programs.git.userName = "Rishabh5321";

  # Enhanced diffs
  # programs.git.delta.enable = true;
  programs.git.difftastic.enable = true;
  programs.git.difftastic.display = "inline";

  # GitHub CLI
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.gh.enable
  # Aliases config in ./gh-aliases.nix
  programs.gh.enable = true;
  programs.gh.settings.version = 1;
  programs.gh.settings.git_protocol = "ssh";
}
