{ pkgs }:
[
  (import ./screenshootin.nix { inherit pkgs; })
  pkgs.wayland-protocols
  pkgs.wayland-utils
]
