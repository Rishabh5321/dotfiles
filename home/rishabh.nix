{ pkgs, ... }:

{
  imports = [
    ./../modules/user/development/git.nix
    ./../modules/user/development/lazygit.nix
    ./../modules/user/files
    ./../modules/user/monitor
    ./../modules/user/shells
    ./../modules/user/shells/oh-my-posh.nix
    # ./../modules/user/terminal/alacritty.nix
    # ./../modules/user/terminal/kitty.nix
    ./../modules/user/utilities/atuin.nix
    ./../modules/user/utilities/tealdeer.nix
    ./../modules/user/utilities/zoxide.nix
  ];

  # Set your username
  home.username = "rishabh";
  home.homeDirectory = "/home/rishabh";

  # Nicely reload system units
  systemd.user.startServices = "sd-switch";

  # Basic packages
  home.packages = with pkgs; [
    fastfetch
    geminicommit
    gemini-cli
  ];

  # Set the state version
  home.stateVersion = "25.11";
}
