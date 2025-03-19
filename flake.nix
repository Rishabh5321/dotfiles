{
  description = "Laptop and server config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    #alejandra.url = "github:kamadorueda/alejandra";
    #alejandra.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    akuse-flake.url = "github:Rishabh5321/akuse-flake";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    darkmatter-grub-theme.url = "gitlab:VandalByte/darkmatter-grub-theme";
    darkmatter-grub-theme.inputs.nixpkgs.follows = "nixpkgs";
    nix-gaming.url = "github:fufexan/nix-gaming";
    hyprland.url = "github:hyprwm/Hyprland";
    grayjay.url = "github:rishabh5321/grayjay-flake";
    seanime.url = "github:rishabh5321/seanime-flake";
    thorium.url = "github:Rishabh5321/thorium_flake";
    # miru-flake.url = "github:Rishabh5321/miru-flake";
    #fine-cmdline = {
    #  url = "github:VonHeikemen/fine-cmdline.nvim";
    #  flake = false;
    #};
    #hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils"; # NOTE Temp until fixed upstream
    #nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    #nixpkgs.follows = "nixos-cosmic/nixpkgs";
    #cursor-flake.url = "github:Rishabh5321/cursor-flake";
    #grub2-themes.url = "github:vinceliuice/grub2-themes";
  };
  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, spicetify-nix, akuse-flake, darkmatter-grub-theme, nix-flatpak, ... } @ inputs:
    let
      inherit (self) outputs;
      systems = [ "x86_64-linux" ];
      username = "rishabh";
      wallpaper = "wall1.png";
      flakeDir = "/home/${username}/dotfiles";
      pkgs-stable = import nixpkgs-stable {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
      };
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
      };
      forAllSystems = nixpkgs.lib.genAttrs systems;
      commonConfig = { hostname }: {
        specialArgs = {
          inherit inputs outputs username home-manager wallpaper spicetify-nix flakeDir pkgs-stable;
        };
        modules = [
          ./nixos/${hostname}/configuration.nix
          darkmatter-grub-theme.nixosModule
          inputs.stylix.nixosModules.stylix
          nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
          (_: {
            environment.systemPackages = [ inputs.akuse-flake.packages."x86_64-linux".akuse ];
          })
          {
            home-manager.extraSpecialArgs = {
              inherit inputs outputs username wallpaper flakeDir spicetify-nix pkgs-stable;
            };
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = builtins.readFile (pkgs.runCommand "timestamp"
              {
                nativeBuildInputs = [ pkgs.inetutils ];
              } ''
              date "+backup_%Y-%m-%d_%H-%M-%S_$(hostname)" > $out
            '');
            home-manager.users.rishabh = import ./nixos/${hostname}/home.nix;
          }
        ];
      };
    in
    {
      # Define all packages in one location
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          customPkgs = import ./pkgs pkgs;
        in
        customPkgs // {
          # Add ISO image to packages
          iso = self.nixosConfigurations.iso.config.system.build.isoImage;
          # Set default package
          default = customPkgs.default or self.nixosConfigurations.iso.config.system.build.isoImage;
        }
      );

      #formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        redmi = nixpkgs.lib.nixosSystem (commonConfig { hostname = "redmi"; });
        dell = nixpkgs.lib.nixosSystem (commonConfig { hostname = "dell"; });

        # ISO configuration
        iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs outputs username wallpaper flakeDir;
        };
        modules = [
          # Use the graphical image as base for better hardware support
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix"
          
          # Disable unnecessary stuff from the base image
          ({ lib, ... }: {
            # Disable unnecessary large packages
            environment.defaultPackages = lib.mkForce [];
            #services.xserver.desktopManager.plasma5.enable = lib.mkForce false;
            boot.supportedFilesystems = lib.mkForce [ "btrfs" "ext4" "vfat" ];
            
            # Disable the Calamares installer (saves space)
            environment.systemPackages = lib.mkForce [];
          })
          
          # Our custom ISO configuration
          ./nixos/iso/configuration.nix
          
          # Add stylix module if needed
          #inputs.stylix.nixosModules.stylix
        ];
        };
      };
    };
}
