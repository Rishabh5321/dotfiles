_: {
  # networking = {
  #   # Disable resolvconf to avoid conflicts with systemd-resolved
  #   resolvconf.enable = true;
  # };

  services.resolved = {
    enable = true;
    dnssec = "true"; # Enable DNSSEC validation
  };
}
