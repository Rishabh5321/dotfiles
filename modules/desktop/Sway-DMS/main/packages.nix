{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    quickshell
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
