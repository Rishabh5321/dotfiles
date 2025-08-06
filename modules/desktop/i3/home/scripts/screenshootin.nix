{ pkgs, ... }:

pkgs.writeShellScriptBin "screenshootin" ''
  maim -s | xclip -selection clipboard -t image/png
''
