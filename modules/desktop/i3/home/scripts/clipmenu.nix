{ pkgs, ... }:

pkgs.writeShellScriptBin "clipmenu" ''
  #!/bin/sh
  ${pkgs.clipmenu}/bin/clipmenu
''
