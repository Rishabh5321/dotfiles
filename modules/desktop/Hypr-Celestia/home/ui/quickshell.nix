{ inputs
, pkgs
, system
, ...
}: {
  # programs.quickshell = {
  #   enable = true;
  # };

  home.packages = [
    inputs.quickshell-custom.packages.${system}.default
    inputs.app2unit.packages.${system}.default
    inputs.caelestia-cli.packages.${system}.default

    pkgs.kdePackages.qt5compat
    pkgs.kdePackages.qtmultimedia
  ];
}
