{pkgs}:
pkgs.appimageTools.wrapType2 rec {
  name = "miru";
  pname = "miru";
  version = "5.5.9";

  src = pkgs.fetchurl {
    url = "https://github.com/ThaUnknown/miru/releases/download/v${version}/linux-Miru-${version}.AppImage";
    hash = "sha256-N9I5YNFIfBmANCnJA3gUmgq04cc5LLfOsYiEdwJupf8=";
  };

  extraInstallCommands = let
    contents = pkgs.appimageTools.extract {inherit pname version src;};
  in ''
    install -m 444 -D ${contents}/miru.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/miru.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${contents}/usr/share/icons $out/share
  '';

  meta = with pkgs.lib; {
    name = "miru";
    description = "Bittorrent streaming software for cats.";
    homepage = "https://github.com/ThaUnknown/miru";
    license = licenses.gpl3;
    maintainers = with maintainers; [karitham];
    platforms = ["x86_64-linux"];
    mainProgram = "miru";
  };
}