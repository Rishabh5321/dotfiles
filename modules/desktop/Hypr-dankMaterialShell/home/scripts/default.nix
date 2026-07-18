{ pkgs, ... }:
[
  # (import ./rofi-launcher.nix { inherit pkgs; })
  # (import ./emopicker9000.nix { inherit pkgs; })
  # (import ./task-waybar.nix { inherit pkgs; })
  # (import ./wallsetter.nix { inherit pkgs; inherit username; })
  # (import ./web-search.nix { inherit pkgs; })
  (import ./screenshootin.nix { inherit pkgs; })
  # (import ./list-sway-bindings.nix { inherit pkgs; inherit host; })
  # (import ./wall-selector.nix { inherit pkgs; })
  pkgs.wayland-protocols
  pkgs.wayland-utils
]
