{ pkgs, ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      init.defaultBranch = "main";
    };
  };

  home.packages = with pkgs; [
    gh
  ];
}
