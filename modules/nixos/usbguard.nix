{username,...}: {
  services.usbguard = {
    enable = true;
    presentControllerPolicy = "apply-policy";
    IPCAllowedGroups = [ "usbguard" ];
    dbus.enable = true;
  };
  users.users.${username} = {
    extraGroups = [ "usbguard" "plugdev" ];
  };
  users.groups.usbguard = { };
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", MODE="0664", GROUP="plugdev"
  '';
  nix.settings.allowed-users = [ "@wheel" "${username}" ];
}