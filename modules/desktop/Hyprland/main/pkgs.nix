{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    #inputs.hyprland-qtutils.packages."${pkgs.system}".default
    #hyprpanel
    brightnessctl
    dunst
    lazydocker
    pavucontrol
    xdg-utils
    xfce.xfce4-pulseaudio-plugin
  ];
}
