{ pkgs, ... }:

let
  # The script that actually does the work
  powerHandler = pkgs.writeShellScriptBin "power-handler" ''
    #!/bin/bash
    ACTION=$1

    # Paths to binaries
    PCTL="${pkgs.power-profiles-daemon}/bin/powerprofilesctl"
    BCTL="${pkgs.brightnessctl}/bin/brightnessctl"

    if [ "$ACTION" = "plugged" ]; then
      $PCTL set performance
      $BCTL set 100%
    elif [ "$ACTION" = "unplugged" ]; then
      $PCTL set balanced
      $BCTL set 30%
    fi
  '';
in
{
  home.packages = [
    pkgs.power-profiles-daemon
    pkgs.brightnessctl
  ];

  # Define User Services
  systemd.user.services = {
    "power-plugged" = {
      Unit.Description = "Switch to Performance Mode";
      Service = {
        Type = "oneshot";
        ExecStart = "${powerHandler}/bin/power-handler plugged";
      };
    };

    "power-unplugged" = {
      Unit.Description = "Switch to Battery Saving Mode";
      Service = {
        Type = "oneshot";
        ExecStart = "${powerHandler}/bin/power-handler unplugged";
      };
    };
  };
}
