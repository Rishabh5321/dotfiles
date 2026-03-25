{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    brightnessctl
    lazydocker
    pamixer
    pavucontrol
    libsecret
    xdg-utils
    pwvucontrol
    swaylock
    swayidle
    wlogout
    grim
    slurp
    wl-clipboard
    swaynotificationcenter
    rofi
  ];
}
