{ pkgs }:
pkgs.appimageTools.wrapType2 rec {
  name = "migu";
  pname = "migu";
  version = "5.6.2";

  src = pkgs.fetchurl {
    url = "https://github.com/NoCrypt/migu/releases/download/v${version}/linux-Migu-${version}.AppImage";
    hash = "sha256-eZEXrxBPvfteoBCKDGBlAFzQob9Ya11cbRqsbwgUPIw=";
  };

  extraInstallCommands =
    let
      contents = pkgs.appimageTools.extract { inherit pname version src; };
    in
    ''
      install -m 444 -D ${contents}/migu.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/migu.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
      cp -r ${contents}/usr/share/icons $out/share
    '';

  meta = with pkgs.lib; {
    name = "migu";
    description = "Bittorrent streaming software for cats.";
    homepage = "https://github.com/ThaUnknown/migu";
    license = licenses.gpl3;
    maintainers = with maintainers; [ karitham ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "migu";
  };
}
