{ config
, outputs
, ...
}: {
  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      substituters = [
      "https://rishabh5321.cachix.org"
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://cosmic.cachix.org/"
      "https://nix-config.cachix.org"
      "https://nix-community.cachix.org"
      "https://ezkea.cachix.org"
    ];
      trusted-substituters = [
      "https://rishabh5321.cachix.org"
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://cosmic.cachix.org/"
      "https://nix-config.cachix.org"
      "https://nix-community.cachix.org"
      "https://ezkea.cachix.org"
    ];
      trusted-public-keys = [
      "rishabh5321.cachix.org-1:mxfBIH2XElE6ieFXXYBA9Ame4mVTbAf1TGR843siggk="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "nix-config.cachix.org-1:Vd6raEuldeIZpttVQfrUbLvXJHzzzkS0pezXCVVjDG4="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      download-buffer-size = 500000000; # 500 MB
    };
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 3d";
    # };
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };
}
