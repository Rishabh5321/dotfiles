{
  pkgs,
  lib,
  config,
  ...
}:
# Got some stuff from here:
# https://github.com/Th4tGuy69/nixos-config/blob/ad922c2b3483e3861ca432046c701f0405831221/packages/seanime.nix#
# Thanks!
let
  cfg = config.modules.home.services.seanime;
  seanime = pkgs.stdenv.mkDerivation rec {
    pname = "seanime";
    version = "2.7.5";

    src = pkgs.fetchurl {
      url = "https://github.com/5rahim/seanime/releases/download/v${version}/seanime-${version}_Linux_x86_64.tar.gz";
      sha256 = "sha256-Vtm+SkrUTUkVQQR4nrpc5pJXMORrBFYH4lj2R1BAFkY=";
    };

    phases = ["installPhase"];

    installPhase = ''
      mkdir -p $out/bin
      tar xzf $src -C $out/bin
    '';

    meta = {
      description = "Open-source media server with a web interface and desktop app for anime and manga";
      homepage = "https://github.com/5rahim/seanime";
      license = lib.licenses.gpl3Only;
    };
  };
in {
  options.modules.home.services.seanime = {
    enable = lib.mkEnableOption "seanime";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      seanime
    ];

    systemd.user.services.seanime = {
      Unit = {
        Description = "Seanime WebServer ";
        After = "network.service";
        X-SwitchMethod = "restart";
      };

      Install = {
        WantedBy = ["default.target"];
      };

      Service = {
        ExecStart = "${seanime}/bin/seanime";
      };
    };
  };
}
