{
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      server_names = [ "cloudflare" ];
      ipv6_servers = true;
      require_dnssec = true;

      # Optional: use DoH or DoQ explicitly
      dnscrypt_servers = false;
      doh_servers = true;
      require_nolog = true;
      require_nofilter = true;

      listen_addresses = [ "127.0.0.1:53" ];
    };
  };

  networking.nameservers = [ "127.0.0.1" ];

  # Avoid systemd-resolved or other conflicts
  services.resolved.enable = false;
  networking.networkmanager.dns = "none";
}
