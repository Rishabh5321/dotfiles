{ config, pkgs, ... }:

{
  systemd = {
    services.nixos-upgrade = {
      description = "NixOS Upgrade Service";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --upgrade";
      };
    };

    timers.nixos-upgrade = {
      description = "NixOS Upgrade Timer";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 08:00:00";
        Persistent = true;
        Unit = "nixos-upgrade.service";
      };
    };
  };
}
