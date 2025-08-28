{ lib, ... }: {
  imports = [
    ./gnome-extensions.nix
    ./gnome.nix
  ];

  qt = {
    enable = true;
    platformTheme.name = lib.mkForce "adwaita";
  };
}
