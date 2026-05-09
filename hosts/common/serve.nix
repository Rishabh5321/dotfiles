_:
{
  services.nix-serve = {
    enable = true;
    bindAddress = "0.0.0.0";
    port = 5000;
    openFirewall = true;
    secretKeyFile = "/var/cache-priv-key.pem";
  };
}
