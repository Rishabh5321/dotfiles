{ pkgs ? import <nixpkgs> { }
,
}:
(pkgs.buildFHSEnv rec {
  pname = "grayjay_bye";
  version = "2";
  # Absolute path to where the contents of Grayjay.Desktop-linux-x64-v{x} is located
  installDir = "/home/rishabh/Grayjay_Bye";

  # grayjay script wrapper that sets cwd to `installdir'
  start-grayjay = pkgs.writeShellScriptBin "start-grayjay" ''cd ${installDir} && ./Grayjay'';

  # grayjay desktop file.
  grayjay-desktop-file = pkgs.makeDesktopItem {
    name = "Grayjay_Bye";
    type = "Application";
    desktopName = "Grayjay";
    genericName = "Desktop Client for Grayjay";
    comment = "A desktop client for Grayjay to stream and download video content";
    icon = "${installDir}/grayjay.png";
    exec = pname;
    path = installDir;
    terminal = false;
    categories = [ "Network" ];
    keywords = [
      "YouTube"
      "Player"
    ];
    startupNotify = true;
    startupWMClass = "Grayjay";
    prefersNonDefaultGPU = false;
  };

  targetPkgs =
    _: with pkgs; [
      start-grayjay
      grayjay-desktop-file
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
  runScript = "start-grayjay";
  extraInstallCommands = ''
    mkdir -p $out/share/applications/
    cp ${grayjay-desktop-file}/share/applications/Grayjay.desktop $out/share/applications/
  '';
})
