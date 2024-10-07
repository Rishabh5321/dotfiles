{
  description = "Laptop and server config";

  inputs = {
    #nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    alejandra.url = "github:kamadorueda/alejandra";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "nixpkgs";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    fine-cmdline = {
      url = "github:VonHeikemen/fine-cmdline.nvim";
      flake = false;
    };
    #aagl.url = "github:ezKEa/aagl-gtk-on-nix/release-24.05";
    #aagl.inputs.nixpkgs.follows = "nixpkgs"; # Name of nixpkgs input you want to use
    darkmatter-grub-theme.url = "gitlab:VandalByte/darkmatter-grub-theme";
    darkmatter-grub-theme.inputs.nixpkgs.follows = "nixpkgs";
    #grub2-themes.url = "github:vinceliuice/grub2-themes";
    # nix-gaming.url = "github:fufexan/nix-gaming";
    # sops-nix.url = "github:Mic92/sops-nix";
    # nixos-cosmic = {
    #   url = "github:lilyinstarlight/nixos-cosmic";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    #sddm-sugar-candy-nix = {
    #  url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
    #  # Optional, by default this flake follows nixpkgs-unstable.
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    #nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    #nixpkgs.follows = "nixos-cosmic/nixpkgs-stable";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , home-manager
    #, aagl
    , spicetify-nix
    , alejandra
      #, nixpkgs-stable
      #, sddm-sugar-candy-nix
      # , nixos-cosmic,
      #chaotic,
      #impermanence,
      #grub2-themes,
    , darkmatter-grub-theme
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      systems = [ "x86_64-linux" ];
      username = "rishabh";
      wallpaper = "wall13.jpg";
      flakeDir = "~/dotfiles";
      pkgs-stable = import nixpkgs-stable {
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
          inherit inputs outputs username home-manager wallpaper spicetify-nix flakeDir pkgs-stable;
        };
        modules = [
          ./nixos/${hostname}/configuration.nix
          #nixos-cosmic.nixosModules.default
          darkmatter-grub-theme.nixosModule
          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          #aagl.nixosModules.default
          #sddm-sugar-candy-nix.nixosModules.default
          #sops-nix.nixosModules.sops
          #chaotic.nixosModules.default
          #impermanence.nixosModules.impermanence
          #grub2-themes.nixosModules.default
          {
            #nixpkgs = {
            #  overlays = [ sddm-sugar-candy-nix.overlays.default ];
            #};
          }
          {
            home-manager.extraSpecialArgs = {
              inherit inputs outputs username wallpaper flakeDir spicetify-nix pkgs-stable;
            };
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backupaa-" + builtins.readFile (pkgs.runCommand "timestamp" { } ''
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
      #nixosModules = import ./modules/nixos;
      #homeManagerModules = import ./modules/home-manager;
      #defaultPackage.x86_64-linux = self.packages.x86_64-linux.lint;
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
