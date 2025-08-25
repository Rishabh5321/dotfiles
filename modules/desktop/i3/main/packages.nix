{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    brightnessctl
    dunst
    lazydocker
    pavucontrol
    libsecret
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    pwvucontrol
    i3
    # i3status
    i3lock
    # i3blocks
    rofi
    feh
    picom
    xidlehook
    betterlockscreen
    maim
    slop
    xclip
    gpick
    copyq
    xdotool
  ];
}
