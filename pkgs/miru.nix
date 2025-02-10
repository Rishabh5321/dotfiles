{ pkgs }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "miru";
  version = "4.5.10";

  src = fetchurl {
    url = "https://github.com/ThaUnknown/miru/releases/download/v${version}/linux-Miru-${version}.AppImage";
    sha256 = "sha256-ptaviLwr0X/MuF517YLW7i9+rtnktcpgHVqMHn+tXWg=";
    name = "linux-${pname}-${version}.AppImage";
  };

  appimageContents = appimageTools.extractType2 {
    name = "${pname}-${version}";
    inherit src;
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/${pname} $out/share/applications

    cp -a ${appimageContents}/{locales,resources} $out/share/${pname}
    cp -a ${appimageContents}/miru.desktop $out/share/applications/${pname}.desktop
    cp -a ${appimageContents}/usr/share/icons $out/share

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'

    runHook postInstall
  '';

  postFixup = ''
    makeWrapper ${electron}/bin/electron $out/bin/${pname} \
      --add-flags $out/share/${pname}/resources/app.asar \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ stdenv.cc.cc ]}"
  '';
}