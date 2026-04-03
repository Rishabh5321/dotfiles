{
  security.rtkit.enable = true;
  security.sudo.enable = true;
  security.sudo.extraRules = [{
    users = [ "rishabh" ]; # Replace with your actual username
    commands = [{
      command = "/run/current-system/sw/bin/docker-compose";
      options = [ "NOPASSWD" ];
    }];
  }];
  security.pam.services.sddm = { };
}
