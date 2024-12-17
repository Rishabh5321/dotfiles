{
  description = "Laptop and server config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-24.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    alejandra.url = "github:kamadorueda/alejandra";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    fine-cmdline = {
      url = "github:VonHeikemen/fine-cmdline.nvim";
      flake = false;
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    darkmatter-grub-theme.url = "gitlab:VandalByte/darkmatter-grub-theme";
    darkmatter-grub-theme.inputs.nixpkgs.follows = "nixpkgs";
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , spicetify-nix
    , alejandra
    , darkmatter-grub-theme
    , nix-flatpak
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      systems = [ "x86_64-linux" ];
      username = "rishabh";
      wallpaper = "wall138.jpg";
      flakeDir = "~/dotfiles";
      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
      };
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
      };
      formatter = forAllSystems (system: nixpkgs.legacyPackages."${system}".nixpkgs-fmt);
      forAllSystems = nixpkgs.lib.genAttrs systems;

      commonConfig = { hostname }: {
        specialArgs = {
          inherit inputs outputs username home-manager wallpaper spicetify-nix flakeDir pkgs-unstable;
        };
        modules = [
          ./nixos/${hostname}/configuration.nix
          darkmatter-grub-theme.nixosModule
          inputs.stylix.nixosModules.stylix
          nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit inputs outputs username wallpaper flakeDir spicetify-nix pkgs-unstable;
            };
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension =
              "b-"
              + builtins.readFile (pkgs.runCommand "timestamp" { } ''
                date "+%Y%m%d%H%M%S" > $out
              '');
            home-manager.users.rishabh = import ./nixos/${hostname}/home.nix;
          }
        ];
      };
    in
    {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        redmi = nixpkgs.lib.nixosSystem (commonConfig {
          hostname = "redmi";
        });
        dell = nixpkgs.lib.nixosSystem (commonConfig {
          hostname = "dell";
        });
      };
    };
}
