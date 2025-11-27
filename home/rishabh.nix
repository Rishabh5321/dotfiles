{ pkgs, nixgl, config, ... }:

{
  imports = [
    # ./../modules/user/development/git.nix
    ./../modules/user/development/lazygit.nix
    ./../modules/user/files
    ./../modules/user/monitor
    ./../modules/user/shells
    ./../modules/user/shells/oh-my-posh.nix
    ./../modules/user/terminal/alacritty.nix
    ./../modules/user/terminal/kitty.nix
    ./../modules/user/utilities/atuin.nix
    ./../modules/user/utilities/tealdeer.nix
    ./../modules/user/utilities/zoxide.nix
  ];

  programs.alacritty.package = config.lib.nixGL.wrap pkgs.alacritty;
  programs.kitty.package = config.lib.nixGL.wrap pkgs.kitty;

  targets.genericLinux.nixGL.packages = import nixgl { inherit pkgs; };
  targets.genericLinux.nixGL.defaultWrapper = "mesa"; # or the driver you need
  targets.genericLinux.nixGL.installScripts = [ "mesa" ];

  # Set your username
  home.username = "rishabh";
  home.homeDirectory = "/home/rishabh";

  # Nicely reload system units
  systemd.user.startServices = "sd-switch";

  # Basic packages
  home.packages = with pkgs; [
    (config.lib.nixGL.wrap delfin)
    fastfetch
    geminicommit
    nil
    nixd
    nixpkgs-fmt
    gemini-cli
  ];

  # Set the state version
  home.stateVersion = "26.05";
}
