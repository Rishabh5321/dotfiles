{ config, pkgs, ... }: {
  networking = {
    nameservers = [ "1.1.1.1" "1.0.0.1" ]; # Cloudflare DNS
    resolvconf.enable = false;
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    fallbackDns = [ "8.8.8.8" "8.8.4.4" ]; # Fallback to Google DNS
    extraConfig = ''
      DNSOverHTTPS=yes
    '';
    domains = [ "~." ]; # Use encrypted DNS for all domains
    dnsoverhttps = "https://1.1.1.1/dns-query https://1.0.0.1/dns-query";
  };
}