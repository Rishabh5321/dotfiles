{
  nix.settings = {
    substituters = [
      "https://buildcache.cachix.org"
      #"http://192.168.1.100:5500"
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://cosmic.cachix.org/"
      "https://nix-config.cachix.org"
      "https://nix-community.cachix.org"
      "https://ezkea.cachix.org"
    ];

    trusted-substituters = [
      "https://buildcache.cachix.org"
      #"http://192.168.1.100:5500"
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://cosmic.cachix.org/"
      "https://nix-config.cachix.org"
      "https://nix-community.cachix.org"
      "https://ezkea.cachix.org"
    ];

    trusted-public-keys = [
      "buildcache.cachix.org-1:wSD0TZc1ZAIuI9LMRJiAytEZGQc9MkPqeICrByOFFAE="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "nix-config.cachix.org-1:Vd6raEuldeIZpttVQfrUbLvXJHzzzkS0pezXCVVjDG4="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
  };
}
