{
  description = "Laptop and server config";

  inputs = {
    ######################
    # Core Infrastructure
    ######################

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    determinate = {
      url = "github:DeterminateSystems/determinate";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ######################
    # System Modules & Frameworks
    ######################

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    nixgl.url = "github:nix-community/nixGL";

    ######################
    # Desktop & Theming
    ######################

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.gnome-shell.url = "github:GNOME/gnome-shell/ef02db02bf0ff342734d525b5767814770d85b49";
    };

    # darkmatter-grub-theme = {
    #   url = "gitlab:VandalByte/darkmatter-grub-theme";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Shells / Desktop Components
    caelestia-cli.url = "github:caelestia-dots/cli";
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.caelestia-cli.follows = "caelestia-cli";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:quickshell-mirror/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ######################
    # Applications & Gaming
    ######################

    nixcord.url = "github:FlameFlag/nixcord";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";

    lsfg-vk-flake = {
      url = "github:pabloaul/lsfg-vk-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ######################
    # Personal Projects
    ######################

    # better-control.url = "github:Rishabh5321/better-control-flake";
    # seanime.url = "github:Rishabh5321/seanime-flake";
    # playtorrio.url = "github:Rishabh5321/playtorrio-flake";
    # fladder.url = "github:Rishabh5321/fladder-flake";
    # zed-editor.url = "github:Rishabh5321/zed-editor-flake";

    custom-packages.url = "github:Rishabh5321/custom-packages-flake";

    wallpapers-repo = {
      url = "github:Rishabh5321/walls";
      flake = false;
    };

    ######################
    # Inactive/Commented
    ######################

    /*
      hyprland.url = "github:hyprwm/hyprland";
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
           nixpkgs.follows = "hyprland/nixpkgs";
           systems.follows = "hyprland/systems";
         };
      };
      sddm-sugar-candy-nix = {
         url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
         inputs.nixpkgs.follows = "nixpkgs";
      };
      dgop = {
         url = "github:AvengeMedia/dgop";
         inputs.nixpkgs.follows = "nixpkgs";
      };
    */
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , home-manager
    , # , sddm-sugar-candy-nix
      nur
    , wallpapers-repo
    , lsfg-vk-flake
    , system-manager
    , #, nix-colorizer
      #, plasma-manager
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "rishabh";
      wallpaper = "wall47.png";
      flakeDir = "/home/${username}/dotfiles ";
      wallpapers = "${wallpapers-repo}/src";

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
          # sddm-sugar-candy-nix.overlays.default
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
          # sddm-sugar-candy-nix
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
            # inputs.darkmatter-grub-theme.nixosModule
            # inputs.distro-grub-themes.nixosModules.${system}.default
            inputs.stylix.nixosModules.stylix
            inputs.nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            # sddm-sugar-candy-nix.nixosModules.default
            nur.modules.nixos.default
            lsfg-vk-flake.nixosModules.default
            inputs.determinate.nixosModules.default
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

      systemConfigs = {
        default = system-manager.lib.makeSystemConfig {
          modules = [
            ./system-manager/configuration.nix
            {
              nixpkgs.hostPlatform = system;
            }
          ];
          extraSpecialArgs = commonArgs // {
            inherit inputs;
            outputs = self;
          };
        };
      };

      nixosConfigurations =
        (builtins.listToAttrs (
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
        ))
        // {
          iso = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
              username = "nixos";
              inherit (nixpkgs) lib;
            };
            modules = [
              ./hosts/iso/configuration.nix
              inputs.stylix.nixosModules.stylix
            ];
          };
        };

      packages.${system} = import ./pkgs pkgs;

      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.git
          pkgs.home-manager
          pkgs.gnumake
          pkgs.nil # Nix LSP server
          pkgs.nixd # Nix language server
          pkgs.nixpkgs-fmt # Nix code formatter
          pkgs.nixpkgs-review # Nixpkgs PR review tool
          pkgs.nix-prefetch # Nix package prefetcher
          pkgs.nix-prefetch-github # Fetch GitHub repos for Nix
          pkgs.nix-update # Nix package update tool
        ];
        name = "dotfiles";
        shellHook = ''
          echo "Welcome to the dotfiles dev shell!"
        '';
      };

      homeConfigurations = {
        "${username}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = commonArgs // {
            # inherit nixgl;
          };
          modules = [
            {
              programs.home-manager.enable = true;
            }
            inputs.stylix.homeModules.stylix
            ./system-manager/home/${username}.nix
          ];
        };
      };
    };
}
