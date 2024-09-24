{
  description = "Laptop and server config";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
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
    #nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";
    #nix-software-center.url = "github:snowfallorg/nix-software-center";
    #nix-github-actions = {
    #  url = "github:zhaofengli/nix-github-actions/matrix-name";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    #chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    # hyprland-plugins.inputs.hyprland.follows = "hyprland";
    #impermanence.url = "github:nix-community/impermanence";
    fine-cmdline = {
      url = "github:VonHeikemen/fine-cmdline.nvim";
      flake = false;
    };
    aagl.url = "github:ezKEa/aagl-gtk-on-nix/release-24.05";
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
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , aagl
    , spicetify-nix
    , alejandra
      #,nixpkgs-stable
      #, sddm-sugar-candy-nix
    , #nixos-cosmic,
      #chaotic,
      #impermanence,
      #grub2-themes,
      darkmatter-grub-theme
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      systems = [ "x86_64-linux" ];
      username = "rishabh";
      wallpaper = "wall126.png";
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
          inherit inputs outputs username home-manager wallpaper spicetify-nix flakeDir pkgs pkgs-unstable aagl;
        };
        modules = [
          ./nixos/${hostname}/configuration.nix
          #nixos-cosmic.nixosModules.default
          darkmatter-grub-theme.nixosModule
          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          aagl.nixosModules.default
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
              inherit inputs outputs username wallpaper flakeDir spicetify-nix pkgs pkgs-unstable;
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
