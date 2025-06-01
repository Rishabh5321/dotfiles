# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{ ... }:
{
  imports = [
    ./alacritty.nix
    ./atuin.nix
    ./btop.nix
    ./cava.nix
    ./eza.nix
    ./fastfetch.nix
    ./fzf.nix
    ./git.nix
    ./ghostty.nix
    ./htop.nix
    ./kitty.nix
    #./kodi.nix
    #./libnotify.nix
    #./mangohud.nix
    #./nvchad.nix
    #./nvf.nix
    ./oh-my-posh.nix
    #./plasma.nix
    #./rofi/rofi.nix
    ./seanime.nix
    ./spicetify.nix
    ./stylix.nix
    ./virtualisation.nix
    ./wofi.nix
    #./zed.nix
    ./zen.nix
    ./zsh.nix
  ];
  home.sessionVariables = {
    NH_OS_FLAKE = "$HOME/dotfiles";
  };
}
