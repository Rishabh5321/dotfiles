{
  stdenv,
  lib,
  fetchurl,
  buildFHSEnv,
  writeShellScript,

  unzip,

  libz,
  icu,
  openssl,

  xorg,

  gtk3,
  glib,
  nss,
  nspr,
  dbus,
  atk,
  cups,
  libdrm,
  expat,
  libxkbcommon,
  pango,
  cairo,
  udev,
  alsa-lib,
  mesa,
  libGL,
  libsecret,
}:

let
  grayjay-app = stdenv.mkDerivation {
    pname = "grayjay-app";
    version = "0.1.0";

    src = fetchurl {
      url = "https://updater.grayjay.app/Apps/Grayjay.Desktop/Grayjay.Desktop-linux-x64.zip";
      hash = "sha256-MU4AJVKkE80/E9ikq9RKIL9Z3npwmC2N0PHybd++jQM=";
    };

    buildInputs = [
      unzip
    ];

    sourceRoot = ".";

    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/bin $out/share
      unzip -d $out $src && f=($out/*) && mv $out/*/* $out
      rm $out/Portable
    '';

    meta = with lib; {
      homepage = "https://grayjay.app/desktop/";
      description = "Grayjay Desktop";
      platforms = platforms.linux;
    };
  };
in
buildFHSEnv {
  name = "grayjay";
  targetPkgs = pkgs: [
    grayjay-app

    libz
    icu
    openssl # For updater

    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb

    gtk3
    glib
    nss
    nspr
    dbus
    atk
    cups
    libdrm
    expat
    libxkbcommon
    pango
    cairo
    udev
    alsa-lib
    mesa
    libGL
    libsecret
  ];

  multiPkgs = pkgs: [ libGL ];
  runScript = writeShellScript "grayjay-script" ''
    mkdir -p ~/Grayjay
    cp -r ${grayjay-app}/* ~/Grayjay/
    cd ~/Grayjay
    ./Grayjay
  '';
}