{ pkgs, ... }: {
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi;
      extraConfig = {
        modi = "drun,filebrowser,run";
        show-icons = true;
        icon-theme = "Papirus";
        font = "JetBrainsMono Nerd Font Mono 12";
        drun-display-format = "{icon} {name}";
        display-drun = " Apps";
        display-run = " Run";
        display-filebrowser = " File";
        terminal = "kitty";
      };
      theme = ./theme.rasi;
    };
  };
}
