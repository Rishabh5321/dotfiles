{
  description = "Laptop and server config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-24.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs-stable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    alejandra.url = "github:kamadorueda/alejandra";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    miru-flake.url = "github:Rishabh5321/miru-flake";
    #fine-cmdline = {
    #  url = "github:VonHeikemen/fine-cmdline.nvim";
    #  flake = false;
    #};
    #hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils"; # NOTE Temp until fixed upstream
    #nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    #nixpkgs.follows = "nixos-cosmic/nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    cursor-flake.url = "github:Rishabh5321/cursor-flake";
    #darkmatter-grub-theme.url = "gitlab:VandalByte/darkmatter-grub-theme";
    #darkmatter-grub-theme.inputs.nixpkgs.follows = "nixpkgs";
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , home-manager
    , spicetify-nix
    , alejandra
    , miru-flake
    , cursor-flake
      #, darkmatter-grub-theme
    , grub2-themes
    , nix-flatpak
      #, nixos-cosmic
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      systems = [ "x86_64-linux" ];
      username = "rishabh";
      wallpaper = "wall1.png";
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
          #darkmatter-grub-theme.nixosModule
          #nixos-cosmic.nixosModules.default
          inputs.stylix.nixosModules.stylix
          nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
          grub2-themes.nixosModules.default
          {
            home-manager.extraSpecialArgs = {
              inherit inputs outputs username wallpaper flakeDir spicetify-nix pkgs-stable;
            };
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = builtins.readFile (pkgs.runCommand "timestamp" { } ''
              date "+backup_%Y-%m-%d_%H-%M-%S_$(hostname)" > $out
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
