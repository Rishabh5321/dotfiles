{ inputs, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    inputs.caelestia-shell.packages.${pkgs.system}.default
    # inputs.quickshell.packages."${system}".default
    # blueman
    brightnessctl
    # dunst
    # hyprpanel
    lazydocker
    pavucontrol
    libsecret
    xdg-utils
    pwvucontrol
    fuzzel
  ];
}
