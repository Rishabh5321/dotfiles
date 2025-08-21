{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    #inputs.hyprland-qtutils.packages."${pkgs.system}".default
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
    xfce.xfce4-pulseaudio-plugin
  ];
}
