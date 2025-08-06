{ ... }:

{
  imports = [
    ./sddm.nix
    ./hardware.nix
    ./services.nix
    ./packages.nix
    ./xserver.nix
    ./security.nix
  ];
}
