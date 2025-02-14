{ pkgs }:
pkgs.appimageTools.wrapType2 rec {
  name = "akuse";
  pname = "akuse";
  version = "1.10.1";

  src = pkgs.fetchurl {
    url = "https://github.com/akuse-app/akuse/releases/download/${version}/linux-akuse-${version}.AppImage";
    hash = "sha256-AhaGiZ/Vx9nJmIXrzZ1JMLqjWfQDyoKpzl55NT712Ro=";
  };

  extraInstallCommands =
    let
      contents = pkgs.appimageTools.extract { inherit pname version src; };
    in
    ''
      install -m 444 -D ${contents}/akuse.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/akuse.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
      cp -r ${contents}/usr/share/icons $out/share
    '';

  meta = with pkgs.lib; {
    name = "akuse";
    description = "Anime Streaming App";
    homepage = "https://github.com/akuse-app/akuse";
    license = licenses.gpl3;
    maintainers = with maintainers; [ karitham ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "akuse";
  };
}
