{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    brightnessctl
    lazydocker
    pavucontrol
    libsecret
    xdg-utils
    xfce.xfce4-pulseaudio-plugin
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
