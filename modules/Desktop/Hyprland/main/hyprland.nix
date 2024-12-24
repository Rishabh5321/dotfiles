# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
{pkgs, ...}: {
  programs = {
    hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    dunst
    lazydocker
    pavucontrol
    xfce.xfce4-pulseaudio-plugin
  ];

  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      wayland = {
        enable = true;
      };
      settings = {
        Autologin = {
          Session = "hyprland";
         User = "rishabh";
        };
      };
      autoNumlock = true;
    };
  };
}
