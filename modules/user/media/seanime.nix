{ inputs, ... }:
{
  imports = [
    inputs.custom-packages.nixosModules.seanime
  ];

  modules.home.services.seanime.enable = true;
}
