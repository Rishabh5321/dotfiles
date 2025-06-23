{ username, ... }: {
  # Enable USBGuard for controlling access to USB devices
  services.usbguard = {
    enable = true;

    # Enforce the current policy on USB devices
    presentControllerPolicy = "apply-policy";

    # Allow IPC access to users in the usbguard group
    IPCAllowedGroups = [ "usbguard" ];

    # Enable D-Bus interface for USBGuard (required by some tools/frontends)
    dbus.enable = true;
  };

  # Define the usbguard group
  users.groups.usbguard = { };

  # Add the specified user to usbguard and plugdev groups
  users.users.${username} = {
    extraGroups = [ "usbguard" "plugdev" ];
  };

  # Set udev rules to allow group access to USB devices
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", MODE="0664", GROUP="plugdev"
  '';

  # Allow the user and wheel group to use nix commands
  nix.settings.allowed-users = [ "@wheel" "${username}" ];
}
