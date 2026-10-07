{ inputs, ... }: {
  imports = [
    inputs.serpantinum.nixosModules.default
  ];

  programs.serpantinum.enable = true;
}
