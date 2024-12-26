{ config, pkgs, ... }:

{
  systemd = {
    services.nixos-upgrade = {
      description = "NixOS Upgrade Service";
      path = [
        pkgs.nix
        pkgs.git
      ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake /home/rishabh/dotfiles#";
        WorkingDirectory = "/home/rishabh/dotfiles";
        # Run as root since we need to modify system files
        User = "root";
      };

      environment = {
        HOME = "/root";
        NIX_PATH = "/nix/var/nix/profiles/per-user/root/channels";
      };
    };

    timers.nixos-upgrade = {
      description = "NixOS Upgrade Timer";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 10:00:00";
        Persistent = true;
        Unit = "nixos-upgrade.service";
      };
    };
  };
}
