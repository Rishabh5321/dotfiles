{pkgs, inputs, ...}: {
   nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };
  environment.systemPackages = [ # or home.packages
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge
  ];
  #programs.steam.platformOptimizations.enable = true;
}