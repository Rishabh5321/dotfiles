{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    brightnessctl
    pamixer
    pavucontrol
    grim
    slurp
    swappy
    wl-clipboard
    rofi
    swaylock-effects
    swayidle
    wlogout
    swaynotificationcenter
    playerctl
  ];
}
