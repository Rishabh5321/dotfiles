{ pkgs, ... }:

let
  cursor = import ../cursor.nix { inherit pkgs; };
in
{
  # Make the cursor available system-wide so the SDDM greeter and
  # non-Home-Manager applications can find it.
  environment.systemPackages = [ cursor.package ];

  environment.sessionVariables = {
    XCURSOR_THEME = cursor.name;
    XCURSOR_SIZE = toString cursor.size;
    HYPRCURSOR_THEME = cursor.name;
    HYPRCURSOR_SIZE = toString cursor.size;
  };
}
