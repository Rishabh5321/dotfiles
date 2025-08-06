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
    xfce.xfce4-pulseaudio-plugin
    i3
    # i3status
    i3lock
    # i3blocks
    rofi
    feh
    picom
    xautolock
    betterlockscreen
    maim
    slop
    xclip
    gpick
    copyq
    xdotool
  ];
}
