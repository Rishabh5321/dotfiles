# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
{ inputs, pkgs, ... }: {
  programs = {
    hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    inputs.hyprland-qtutils.packages."${pkgs.system}".default
    brightnessctl
    dunst
    lazydocker
    pavucontrol
    xfce.xfce4-pulseaudio-plugin
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

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
