{ pkgs, ... }:
{
  programs.lutris = {
    enable = true;
    package = pkgs.lutris;
    defaultWinePackage = pkgs.proton-ge-bin;
    protonPackages = [ pkgs.proton-ge-bin ];
    winePackages = [ pkgs.wineWow64Packages.full ];
  };
}
