{ pkgs, inputs, ... }: {

  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    brightnessctl
    lazydocker
    pamixer
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
    rofi
  ];
}
