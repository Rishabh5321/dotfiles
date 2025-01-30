# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    ./alacritty.nix
    ./atuin.nix
    ./btop.nix
    ./cava.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./htop.nix
    ./kitty.nix
    ./libnotify.nix
    #./mangohud.nix
    ./neovim.nix
    ./oh-my-posh.nix
    #./plasma.nix
    #./rofi/rofi.nix
    ./spicetify.nix
    ./stylix.nix
    ./wofi.nix
    ./zsh.nix
  ];
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

}
