{ pkgs, username, host }:
[
  (import ./rofi-launcher.nix { inherit pkgs; })
  (import ./emopicker9000.nix { inherit pkgs; })
  (import ./task-waybar.nix { inherit pkgs; })
  #(import ./squirtle.nix {inherit pkgs;})
  #(import ./nvidia-offload.nix { inherit pkgs; })
  (import ./wallsetter.nix { inherit pkgs; inherit username; })
  (import ./web-search.nix { inherit pkgs; })
  (import ./screenshootin.nix { inherit pkgs; })
  (import ./list-hypr-bindings.nix { inherit pkgs; inherit host; })
  #(import ./startup.nix {inherit pkgs;})
  #(import ./battery.nix {inherit pkgs;})
  pkgs.wayland-protocols
  pkgs.wayland-utils
  pkgs.wlr-randr
  pkgs.brightnessctl
  # pkgs.waybar
  pkgs.kdePackages.kdeconnect-kde
  pkgs.hyprpolkitagent # password prompt
]
