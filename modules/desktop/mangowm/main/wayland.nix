{ inputs, ... }:
{
  # imports = [
  #   inputs.mango.nixosModules.mango
  # ];

  programs.mango = {
    enable = true;
  };
}
