{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    #inputs.hyprland-qtutils.packages."${pkgs.stdenv.hostPlatform.system}".default
    # inputs.quickshell.packages."${system}".default
    brightnessctl
    blueman
    pamixer
    # dunst
    # hyprpanel
    lazydocker
    pavucontrol
    libsecret
    waypaper
    xdg-utils
    pwvucontrol
  ];
}
