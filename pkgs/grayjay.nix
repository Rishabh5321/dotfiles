{
  buildDotnetModule,
  fetchgit,
  dotnetCorePackages,
  buildNpmPackage,
  lib,
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
  gitUpdater,
}:
let
  version = "3";
  src = fetchgit {
    url = "https://gitlab.futo.org/videostreaming/Grayjay.Desktop";
    tag = version;
    hash = "sha256-gI1M/rDTSH16eeknHJfLA2iawoA5iGTKHfwUW4/lvv8=";
    fetchSubmodules = true;
    fetchLFS = true;
  };
  frontend = buildNpmPackage {
    name = "grayjay-frontend";
    inherit version src;
    sourceRoot = "Grayjay.Desktop/Grayjay.Desktop.Web";
    npmBuildScript = "build";
    npmDepsHash = "sha256-pTEbMSAJwTY6ZRriPWfBFnRHSYufSsD0d+hWGz35xFM=";
    installPhase = ''
      runHook preInstall
      cp -r dist/ $out
      runHook postInstall
    '';
  };
in
buildDotnetModule {
  pname = "grayjay";
  inherit version src;
  projectFile = [
    "Grayjay.ClientServer/Grayjay.ClientServer.csproj"
    "Grayjay.Engine/Grayjay.Engine/Grayjay.Engine.csproj"
    "Grayjay.Desktop.CEF/Grayjay.Desktop.CEF.csproj"
    "FUTO.MDNS/FUTO.MDNS/FUTO.MDNS.csproj"
    "JustCef/DotCef.csproj"
  ];
  testProjectFile = [
    "Grayjay.Desktop.Tests/Grayjay.Desktop.Tests.csproj"
    "Grayjay.Engine/Grayjay.Engine.Tests/Grayjay.Engine.Tests.csproj"
  ];
  nugetDeps = ./grayjay_deps.json;
  dotnet-runtime = dotnetCorePackages.aspnetcore_8_0;
  executables = [ "Grayjay" ];
  preBuild = ''
    rm -r Grayjay.ClientServer/wwwroot/web
    cp -r ${frontend} Grayjay.ClientServer/wwwroot/web
  '';
  postInstall = ''
    chmod +x $out/lib/grayjay/cef/dotcefnative
    rm $out/lib/grayjay/Portable
    ln -s /tmp/grayjay-launch $out/lib/grayjay/launch
    ln -s /tmp/grayjay-cef-launch $out/lib/grayjay/cef/launch
  '';
  makeWrapperArgs = [
    "--chdir"
    "${placeholder "out"}/lib/grayjay"
  ];
  runtimeDeps = [
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
  passthru.updateScript = gitUpdater { };
  meta = {
    description = "Multi-platform media application that allows you to watch content from multiple platforms in a single application";
    longDescription = ''Grayjay is a multi-platform media application that allows you to watch content from multiple platforms in a single application. Using an extendable plugin system developers can make new integrations with additional platforms. Plugins are cross-compatible between Android and Desktop.'';
    homepage = "https://grayjay.app/desktop/";
    # license = lib.licenses.sfl;
    maintainers = with lib.maintainers; [ samfundev ];
    platforms = lib.platforms.linux;
    mainProgram = "Grayjay";
  };
}