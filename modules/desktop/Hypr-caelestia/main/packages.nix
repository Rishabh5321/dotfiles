{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # Caelestia shell/CLI runtime dependencies
    brightnessctl
    ddcutil
    lm_sensors
    fuzzel
    libnotify
    playerctl
    slurp
    grim
    swappy
    hyprpicker
    gpu-screen-recorder

    # Audio & desktop utilities
    pavucontrol
    pwvucontrol
    libsecret
    xdg-utils
    thunar
  ];
}
