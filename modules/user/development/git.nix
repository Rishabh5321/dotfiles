{ pkgs, ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      init.defaultBranch = "main";
      user.email = "Rishabh5321";
      user.name = "rishabh98818@outlook.com";
    };
  };

  home.packages = with pkgs; [
    gh
  ];
}
