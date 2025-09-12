# hosts/common/workstation.nix
{ ... }: {
  imports = [
    ./power-laptop.nix
    # ./tailscale-client.nix
  ];
}
