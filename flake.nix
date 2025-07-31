{
  description = "Laptop and server config";

  inputs = {
    ######################
    # Core Nix/Nixpkgs
    ######################

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ######################
    # Desktop/WM
    ######################

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # plasma-manager = {
    #   url = "github:nix-community/plasma-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.home-manager.follows = "home-manager";
    # };

    # hyprpanel = {
    #   url = "github:Jas-SinghFSU/HyprPanel";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # ags = {
    #   url = "github:Aylur/ags";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # hyprpolkitagent = {
    #   url = "github:hyprwm/hyprpolkitagent";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    ######################
    # Personal Projects
    ######################

    better-control.url = "github:Rishabh5321/better-control-flake";
    gemini-cli.url = "github:Rishabh5321/gemini-cli-flake";
    seanime.url = "github:Rishabh5321/seanime-flake";
    zed-editor-flake.url = "github:Rishabh5321/zed-editor-flake";

    # akuse-flake.url = "github:rishabh5321/akuse-flake";
    # grayjay.url = "github:Rishabh5321/grayjay-flake";
    # thorium.url = "github:rishabh5321/thorium_flake";

    ######################
    # Applications/Tools
    ######################

    darkmatter-grub-theme = {
      url = "gitlab:VandalByte/darkmatter-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nvchad4nix = {
    #   url = "github:nix-community/nix4nvchad";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nvf.url = "github:notashelf/nvf";
    # nix-colorizer.url = "github:nutsalhan87/nix-colorizer";
    # determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    # distro-grub-themes = {
    #   url = "github:AdisonCavani/distro-grub-themes";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    ######################
    # Assets/Others
    ######################

    wallpapers-repo = {
      url = "github:Rishabh5321/wallsite";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , home-manager
    , sddm-sugar-candy-nix
    , chaotic
    , nur
    , wallpapers-repo
    , ghostty
      #, nix-colorizer
      #, plasma-manager
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "rishabh";
      wallpaper = "wall4.jpg";
      flakeDir = "/home/${username}/dotfiles";
      wallpapers = "${wallpapers-repo}/wallpapers";

      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
        overlays = [
          # inputs.hyprpanel.overlay
          sddm-sugar-candy-nix.overlays.default
        ];
      };

      commonArgs = {
        inherit
          inputs
          system
          username
          wallpaper
          flakeDir
          pkgs-stable
          nur
          # nix-colorizer
          sddm-sugar-candy-nix
          wallpapers
          ;
        inherit (inputs) spicetify-nix;
      };

      mkHost =
        { hostname }:
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
            #inputs.distro-grub-themes.nixosModules.${system}.default
            inputs.stylix.nixosModules.stylix
            inputs.nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            sddm-sugar-candy-nix.nixosModules.default
            chaotic.nixosModules.default
            nur.modules.nixos.default
            #inputs.determinate.nixosModules.default
            # Home Manager configuration integrated into NixOS
            {
              home-manager = {
                extraSpecialArgs = homeManagerSpecialArgs;
                useUserPackages = true;
                backupFileExtension = "bak";
                # sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
                users.${username} = import ./hosts/${hostname}/home.nix;
              };
            }
          ];
        };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      overlays = import ./overlays { inherit inputs self system; };

      nixosConfigurations = (builtins.listToAttrs (
        map
          (folder: {
            name = folder;
            value = mkHost { hostname = folder; };
          })
          (
            builtins.filter (name: builtins.pathExists (./hosts + "/${name}/configuration.nix")) (
              builtins.attrNames (builtins.readDir ./hosts)
            )
          )
      )) // {
        iso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; username = "nixos"; inherit (nixpkgs) lib; };
          modules = [
            ./hosts/iso/configuration.nix
            inputs.stylix.nixosModules.stylix
            inputs.darkmatter-grub-theme.nixosModule
          ];
        };
      };
    };
}
