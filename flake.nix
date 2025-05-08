# ./flake.nix
{
  description = "Laptop and server config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };
    darkmatter-grub-theme = {
      url = "gitlab:VandalByte/darkmatter-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpolkitagent = {
      url = "github:hyprwm/hyprpolkitagent";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nix-gaming.url = "github:fufexan/nix-gaming";
    akuse-flake.url = "github:Rishabh5321/akuse-flake";
    better-control.url = "github:rishabh5321/better-control-flake";
    seanime.url = "github:rishabh5321/seanime-flake";
    thorium.url = "github:Rishabh5321/thorium_flake";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, sddm-sugar-candy-nix, ... } @ inputs:
    let
      system = "x86_64-linux";
      username = "rishabh";
      wallpaper = "wall9.png";
      flakeDir = "/home/${username}/dotfiles";

      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config = { allowUnfree = true; };
      };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
        overlays = [
          inputs.hyprpanel.overlay
          sddm-sugar-candy-nix.overlays.default
        ];
      };

      commonArgs = {
        inherit inputs system username wallpaper flakeDir pkgs-stable sddm-sugar-candy-nix;
        inherit (inputs) spicetify-nix;
      };

      mkHost = { hostname }:
        let
          nixosSpecialArgs = commonArgs // {
            inherit home-manager;
            inherit self;
            outputs = self;
          };
          homeManagerSpecialArgs = commonArgs // {
            inherit self pkgs;
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = nixosSpecialArgs;
          modules = [
            # Host specific NixOS configuration
            ./hosts/${hostname}/configuration.nix

            # Common NixOS modules
            inputs.darkmatter-grub-theme.nixosModule
            inputs.stylix.nixosModules.stylix
            inputs.nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            sddm-sugar-candy-nix.nixosModules.default
            # Home Manager configuration integrated into NixOS
            {
              home-manager = {
                extraSpecialArgs = homeManagerSpecialArgs;
                useUserPackages = true;
                backupFileExtension = "bak";
                users.${username} = import ./hosts/${hostname}/home.nix;
              };
            }
          ];
        };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      overlays = import ./overlays { inherit inputs self system; };

      nixosConfigurations = {
        redmi = mkHost { hostname = "redmi"; };
        dell = mkHost { hostname = "dell"; };
        server = mkHost { hostname = "server"; };
      };
    };
}
