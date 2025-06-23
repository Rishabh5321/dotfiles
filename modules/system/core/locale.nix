{ options, ... }: {
  # ===== TIME ZONE CONFIGURATION =====
  time.timeZone = "Asia/Kolkata";

  # Network time servers for accurate time synchronization
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

  # ===== INTERNATIONALIZATION & LOCALE =====
  # Primary system locale
  i18n.defaultLocale = "en_US.UTF-8";

  # Additional locale settings for specific categories
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
}
