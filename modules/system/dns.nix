_: {
  networking = {
    # Disable resolvconf to avoid conflicts with systemd-resolved
    resolvconf.enable = false;
  };

  services.resolved = {
    enable = true;
    dnssec = "true"; # Enable DNSSEC validation
    fallbackDns = [ "8.8.8.8" "8.8.4.4" ]; # Fallback to Google DNS
    extraConfig = ''
      DNS=1.1.1.1 1.0.0.1
      DNSOverTLS=yes
      DNSOverHTTPS=yes
      DNSSEC=yes
      FallbackDNS=8.8.8.8 8.8.4.4
      # Use Cloudflare's DoH endpoints
      DNSOverHTTPS=yes
      DNSOverHTTPS=1.1.1.1#cloudflare-dns.com 1.0.0.1#cloudflare-dns.com
    '';
  };
}
