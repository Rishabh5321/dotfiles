{ pkgs, ... }:
{
  nix = {
    package = pkgs.nix;
    settings = {
      # ===== BINARY CACHE CONFIGURATION =====
      # Primary and community binary caches for faster builds
      substituters = [
        "https://cache.nixos.org?priority=10" # official

        "https://rishabh5321.cachix.org" # Personal cache
        "https://nixpkgs-wayland.cachix.org" # Wayland packages
        "https://cosmic.cachix.org/" # COSMIC desktop environment
        "https://nix-config.cachix.org" # Community configurations
        "https://nix-community.cachix.org" # Nix community packages
      ];

      # Public keys for verifying cache authenticity
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

        "rishabh5321.cachix.org-1:mxfBIH2XElE6ieFXXYBA9Ame4mVTbAf1TGR843siggk="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        "nix-config.cachix.org-1:Vd6raEuldeIZpttVQfrUbLvXJHzzzkS0pezXCVVjDG4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      # ===== PERFORMANCE OPTIMIZATIONS =====
      # Automatically optimize store by hard-linking identical files
      auto-optimise-store = true;

      # Large download buffer for better network performance (500 MB)
      download-buffer-size = 500000000;

      # ===== EXPERIMENTAL FEATURES =====
      # Enable modern Nix features
      experimental-features = [
        "nix-command" # New nix CLI interface
        "flakes" # Flake system for reproducible configurations
      ];
    };

    # ===== GARBAGE COLLECTION (DISABLED) =====
    # Automatic cleanup handled by nh instead
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 3d";
    # };
  };
}
