# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
{ lib, ... }: {
  # services.blueman.enable = true;
  programs.seahorse.enable = lib.mkForce true;
}
