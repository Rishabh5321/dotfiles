{ inputs, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    # inputs.quickshell.packages."${system}".default
    # blueman
    brightnessctl
    # dunst
    # hyprpanel
    matugen
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
