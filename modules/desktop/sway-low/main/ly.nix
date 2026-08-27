{pkgs,...}: {
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "dur_file";
      bigclock = "en";
      full_color = true;
      save = true;
      load = true;
      # auto_login_session = "Niri";
      # auto_login_user = config.identity.user;
      default_login = "password";
      dur_file_path = "${
        pkgs.fetchFromGitea {
          domain = "codeberg.org";
          owner = "fairyglade";
          repo = "ly-community";
          rev = "2f22cfaf7d17598c8f60f562d56e16d74b6c99ab";
          hash = "sha256-BQhlvWmEkXNpbUgtGBzbHjdQwRa2jxHhBBNu8sVzIDQ=";
        }
      }/animations/dur/blackhole-smooth-240x67.dur";
    };
  };

  boot.kernelParams = [ "consoleblank=60" ];
}
