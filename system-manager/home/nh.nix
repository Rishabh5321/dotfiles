{ pkgs
, username
, ...
}: {
  # ===== NH (NIX HELPER) CONFIGURATION =====
  programs.nh = {
    enable = true;

    # Automatic cleanup configuration
    clean = {
      enable = true;
      # Keep only the 5 most recent generations, remove older ones
      extraArgs = "--keep 5";
    };

    # Path to your NixOS flake configuration
    flake = "/home/${username}/dotfiles";
  };

  # ===== NIX DEVELOPMENT TOOLS =====
  home.packages = with pkgs; [
    # Enhanced output monitoring for nix builds
    nix-output-monitor

    # Nix version diff tool for comparing system changes
    nvd
  ];
}
