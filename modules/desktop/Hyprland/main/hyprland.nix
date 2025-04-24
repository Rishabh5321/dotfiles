# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
{ pkgs, ... }: {

  #nix.settings = {
  #substituters = [ "https://hyprland.cachix.org" ];
  #trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  #};
  security.pam.services.hyprlock = {
    enableGnomeKeyring = true;
    startSession = true; # Ensure a session is started
  };

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
  services.blueman.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      # inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      # pkgs.xdg-desktop-portal-hyprland
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
