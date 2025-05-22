{ inputs, ... }:
{
  imports = [
    inputs.seanime.nixosModules.seanime
  ];

  modules.home.services.seanime.enable = true;
}
