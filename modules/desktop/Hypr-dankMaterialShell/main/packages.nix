{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    brightnessctl
    kdePackages.kdeconnect-kde
    wofi-emoji
    lazydocker
    pavucontrol
    libsecret
    xdg-utils
    pwvucontrol
    fuzzel
  ];
}
