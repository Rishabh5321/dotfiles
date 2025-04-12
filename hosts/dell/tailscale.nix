{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    tailscale
  ];

  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "server";
  networking.firewall.checkReversePath = "loose";
}
