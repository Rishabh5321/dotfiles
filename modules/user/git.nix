{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "Rishabh5321";
    userEmail = "rishabh98818@outlook.com";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  home.packages = with pkgs; [
    gh
  ];
}
