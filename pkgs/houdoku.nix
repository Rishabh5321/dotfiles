{ pkgs }:
pkgs.appimageTools.wrapType2 rec {
  name = "houdoku";
  pname = "houdoku";
  version = "2.16.0";

  src = pkgs.fetchurl {
    url = "https://github.com/xgi/houdoku/releases/download/v${version}/Houdoku-${version}.AppImage";
    hash = "sha256-AhaGiZ/Vx9nJmIXrzZ1JMLqjWfQDyoKpzl55NT712Ro=";
  };

  extraInstallCommands =
    let
      contents = pkgs.appimageTools.extract { inherit pname version src; };
    in
    ''
      install -m 444 -D ${contents}/miru.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/houdoku.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
      cp -r ${contents}/usr/share/icons $out/share
    '';

  meta = with pkgs.lib; {
    name = "houdoku";
    description = "Manga Reader";
    homepage = "https://github.com/xgi/houdoku";
    license = licenses.gpl3;
    maintainers = with maintainers; [ xgi ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "houdoku";
  };
}
