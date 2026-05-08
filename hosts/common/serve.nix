{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.nix-serve ];
  systemd.services.nix-serve = {
    enable = true;
    description = "Nix Serve";
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.nix-serve}/bin/nix-serve --port 5500 --bind 0.0.0.0 --secret-key-file /var/lib/nix-serve/secret-key.pem";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
