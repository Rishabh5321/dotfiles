{ wallpaper, wallpapers, ... }:

{
  home.file.".fehbg".text = ''
    #!/bin/sh
    feh --bg-fill "${wallpapers}/${wallpaper}"
  '';
}
