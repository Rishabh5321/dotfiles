{ inputs, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    #inputs.hyprland-qtutils.packages."${pkgs.system}".default
    # inputs.quickshell.packages."${system}".default
    brightnessctl
    # dunst
    # hyprpanel
    lazydocker
    pavucontrol
    libsecret
    xdg-utils
    xfce.xfce4-pulseaudio-plugin
  ];
}
