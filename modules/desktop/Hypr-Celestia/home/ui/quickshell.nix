{ inputs
, pkgs
, ...
}: {
  # programs.quickshell = {
  #   enable = true;
  # };

  home.packages = [
    inputs.quickshell.packages."${pkgs.system}".quickshell

    pkgs.kdePackages.qt5compat
    pkgs.kdePackages.qtmultimedia

    inputs.caelestia-cli.packages."${pkgs.system}".default
    inputs.caelestia.packages."${pkgs.system}".default
  ];
}
