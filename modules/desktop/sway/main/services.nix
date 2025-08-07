{ lib, ... }: {
  services.blueman.enable = true;
  programs.seahorse.enable = lib.mkForce true;
}
