{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    brightnessctl
    wofi-emoji
    lazydocker
    pavucontrol
    libsecret
    xdg-utils
    pwvucontrol
    fuzzel
  ];
}
