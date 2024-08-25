{
  ...
}: {
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.xserver.enable = true;
  # services.xserver = {
  #   enable = true;
  #   desktopManager = {
  #     xterm.enable = false;
  #     gnome.enable = true;
  #     # xfce = {
  #     #   enable = true;
  #     # }
  #   };
  #   displayManager.gdm = {
  #     enable = true;
  #   };
  #   #windowManager.i3.enable = true;
  # };
  # #services.displayManager.defaultSession = "xfce";
  # #services.desktopManager.cosmic.enable = true;
  # #services.displayManager.cosmic-greeter.enable = true;

  # environment.systemPackages = with pkgs; [
  #   dconf-editor
  #   gnome-tweaks
  # ];

  # programs.ssh.askPassword = lib.mkForce "true";
}
