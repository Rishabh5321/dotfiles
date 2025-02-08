{ pkgs }:
pkgs.appimageTools.wrapType2 rec {
  name = "unyo";
  pname = "unyo";
  version = "0.6.7";

  src = pkgs.fetchurl {
    url = "https://github.com/K3vinb5/Unyo/releases/download/v${version}/Unyo-v${version}-linux.AppImage";
    hash = "sha256-fHrDewdnseGit1jjvejXUimeCavIPYc0pV4FZLF1o88=";
  };

  extraInstallCommands =
    let
      contents = pkgs.appimageTools.extract { inherit pname version src; };
    in
    ''
      install -m 444 -D ${contents}/Unyo.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/Unyo.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
    
    '';
  #cp -r ${contents}/usr/share/logo.png $out/share
  meta = with pkgs.lib; {
    name = "Unyo";
    description = "Bittorrent streaming software for cats.";
    homepage = "https://github.com/ThaUnknown/unyo";
    license = licenses.gpl3;
    maintainers = with maintainers; [ karitham ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "Unyo";
  };
}
