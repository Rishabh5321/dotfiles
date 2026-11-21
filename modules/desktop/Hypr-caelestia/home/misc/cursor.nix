{ pkgs, lib, ... }:

let
  cursor = import ../../cursor.nix { inherit pkgs; };
in
{
  home.pointerCursor = {
    enable = true;
    inherit (cursor) package name size;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
  };

  # modules/user/theme sets its own cursor theme, so force our choice
  # for this desktop instead of changing every host.
  gtk.cursorTheme = lib.mkForce {
    inherit (cursor) package name size;
  };
}
