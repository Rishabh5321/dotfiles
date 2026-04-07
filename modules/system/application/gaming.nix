{ pkgs, inputs, ... }: {
  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };

  environment.systemPackages = [
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.wine-ge
    # inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.wine-osu
    # inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.wine-tkg
  ];

  programs = {
    steam = {
      enable = false;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };
  };
}
