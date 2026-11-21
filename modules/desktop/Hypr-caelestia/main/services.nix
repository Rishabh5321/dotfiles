{ lib, ... }: {
  programs.seahorse.enable = lib.mkForce true;
}
