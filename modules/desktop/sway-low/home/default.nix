{ ... }:
{
  imports = [
    ./core/sway.nix
    ./core/portal.nix
    ./core/swaylock.nix
    ./core/swayidle.nix
    ./services/swaync.nix
    ./ui/waybar.nix
    ./ui/rofi.nix
    ./ui/wlogout.nix
    ./misc/session-variables.nix
    ./misc/xdg.nix
    ./misc/swappy.nix
  ];
}
