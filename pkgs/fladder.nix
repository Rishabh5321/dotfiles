{ pkgs, appimageTools, fetchurl, stdenv, fetchFromGitHub }:

let
  cleanName = "Fladder";

  version = "0.8.0";
  versionCommit = "a00b5255992ca4b6d5ba5eb5513e960ed780c198";

  src = fetchurl {
    url =
      "https://github.com/DonutWare/Fladder/releases/download/v${version}/Fladder-Linux-${version}.AppImage";
    hash = "sha256-uU/QTfAF22d4RPkv7rJrOkn1/LBwMJRv0wLnolxDD/Y=";
  };

  ghSource = fetchFromGitHub {
    owner = "DonutWare";
    repo = "Fladder";
    rev = versionCommit;
    hash = "sha256-Rpnf4fYsChbCsezBtmqQ8xkaj6HmfnDPvZLSZjPEPJ0=";
  };

  pname = "fladder";

  build = appimageTools.wrapType2 {
    inherit pname version src;

    extraPkgs = _: with pkgs; [ mpv libepoxy ];
  };

  desktopEntry = pkgs.makeDesktopItem {
    name = pname;
    desktopName = cleanName;
    comment = "A client for Jellyfin";
    exec = "${build}/bin/${pname} %f";
    icon = "${ghSource}/icons/production/fladder_icon_desktop.png";
  };

in
stdenv.mkDerivation {
  name = pname;

  src = build;

  installPhase = ''
    mkdir -p $out/bin
    cp bin/${pname} $out/bin/${pname}

    mkdir -p $out/share/applications
    cp ${desktopEntry}/share/applications/${pname}.desktop $out/share/applications/${pname}.desktop
  '';
}
