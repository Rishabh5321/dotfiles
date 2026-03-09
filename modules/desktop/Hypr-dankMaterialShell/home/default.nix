{ ... }:

{
  imports = [
    # Core components
    ./core/hyprland.nix
    ./core/portal.nix

    # Services
    ./services/gnome-keyring.nix

    # UI elements
    ./ui/quickshell.nix

    # Misc
    ./misc/emoji.nix
    ./misc/swappy.nix
    ./misc/xdg.nix
    ./misc/session-variables.nix
  ];

}
