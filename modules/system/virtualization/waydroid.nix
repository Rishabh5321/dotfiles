{ pkgs, ... }:
{
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  environment.systemPackages = with pkgs; [
    android-tools
  ];
}
