{
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      server_names = [ "cloudflare" "quad9-doh" "google" ];

      ipv6_servers = true;
      require_dnssec = true;
      dnscrypt_servers = false;
      doh_servers = true;
      require_nolog = true;
      require_nofilter = true;

      listen_addresses = [ "127.0.0.1:53" ];

      # DNS Cache Settings
      cache = true;
      cache_size = 4096; # Number of cached entries
      cache_min_ttl = 600; # Minimum TTL in seconds (10 minutes)
      cache_max_ttl = 86400; # Maximum TTL in seconds (1 day)
    };
  };

  networking.nameservers = [ "127.0.0.1" ];

  # Avoid systemd-resolved or other conflicts
  services.resolved.enable = false;
  networking.networkmanager.dns = "none";
}
