# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
{ pkgs, ... }: {
  programs = {
    hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
    };
  };

  security.pam.services.hyprlock = {
    enableGnomeKeyring = true;
    startSession = true; # Ensure a session is started
  };

  environment.systemPackages = with pkgs; [
    #inputs.hyprland-qtutils.packages."${pkgs.system}".default
    brightnessctl
    dunst
    lazydocker
    pavucontrol
    xdg-utils
    xfce.xfce4-pulseaudio-plugin
  ];
  services.blueman.enable = true;
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
