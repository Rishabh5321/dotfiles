{ ... }: {
  imports = [
    ./gnome-extensions.nix
    ./gnome.nix
  ];
  stylix.targets.qt.platform = "qtct";
  # Qt configuration
  qt = {
    enable = true;
    platformTheme.name = "qtct"; # Align with Stylix's supported platform
    style.name = "kvantum"; # Use Kvantum as the Qt style
  };
}
