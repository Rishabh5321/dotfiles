{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    brightnessctl
    pamixer
    pavucontrol
    grim
    slurp
    wl-clipboard
    rofi
    swaylock-effects
    swayidle
    wlogout
    swaynotificationcenter
    playerctl
  ];
}
