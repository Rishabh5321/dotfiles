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
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      #formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        redmi = nixpkgs.lib.nixosSystem (commonConfig { hostname = "redmi"; });
        dell = nixpkgs.lib.nixosSystem (commonConfig { hostname = "dell"; });
      };
    };
}
