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

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ######################
    # Desktop/WM
    ######################

    # hyprwm
    hyprland.url = "github:hyprwm/hyprland";

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        hyprgraphics.follows = "hyprland/hyprgraphics";
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ######################
    # Personal Projects
    ######################

    better-control.url = "github:Rishabh5321/better-control-flake";
    seanime.url = "github:Rishabh5321/seanime-flake";

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

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lsfg-vk-flake = {
      url = "github:pabloaul/lsfg-vk-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs = {
        # nixpkgs.follows = "nixpkgs";
        # quickshell.follows = "quickshell";
        caelestia-cli.follows = "caelestia-cli";
      };
    };

    # quickshell = {
    #   url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
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
    , lsfg-vk-flake
      #, nix-colorizer
      #, plasma-manager
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "rishabh";
      wallpaper = "Art/wall1.png";
      flakeDir = "/home/${username}/dotfiles ";
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
            lsfg-vk-flake.nixosModules.default
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

      homeConfigurations = {
        "${username}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = commonArgs;
          modules = [
            {
              lib.stylix.colors = {
                base00 = "1d2021";
                base01 = "32302f";
                base02 = "504945";
                base03 = "665c54";
                base04 = "bdae93";
                base05 = "d5c4a1";
                base06 = "ebdbb2";
                base07 = "fbf1c7";
                base08 = "fb4934";
                base09 = "fe8019";
                base0A = "fabd2f";
                base0B = "b8bb26";
                base0C = "8ec07c";
                base0D = "83a598";
                base0E = "d3869b";
                base0F = "d65d0e";
              };
            }
            ./home/${username}.nix
          ];
        };
      };
    };
}
