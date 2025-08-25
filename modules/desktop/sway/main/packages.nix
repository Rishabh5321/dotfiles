{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    brightnessctl
    lazydocker
    pavucontrol
    libsecret
    xdg-utils
    pwvucontrol
    kdePackages.kdeconnect-kde
    swaylock
    swayidle
    wlogout
    grim
    slurp
    wl-clipboard
    swaynotificationcenter
    rofi-wayland
  ];
}
