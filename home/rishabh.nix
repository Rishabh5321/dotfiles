{ pkgs, ... }:

{
  imports = [
    ./../modules/user
  ];

  # Set your username
  home.username = "rishabh";
  home.homeDirectory = "/home/rishabh";

  # Nicely reload system units
  systemd.user.startServices = "sd-switch";

  # Basic packages
  home.packages = with pkgs; [
    fastfetch
  ];

  # Set the state version
  home.stateVersion = "25.11";
}
