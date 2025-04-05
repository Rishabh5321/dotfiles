# Example Filename: /etc/nixos/modules/users.nix

{ pkgs
, username # Expecting the main username to be passed in (e.g., "rishabh")
#, config # Pass 'config' if needed for e.g. sops or cross-module references
, ...
}:

let
  # Use the passed-in username consistently
  primaryUser = username;
in
{
  # ... (users.mutableUsers, users.groups.usbguard, users.users definitions remain the same) ...

  users.mutableUsers = true;
  users.groups.usbguard = {};
  users.users = {
    "${primaryUser}" = {
      isNormalUser = true;
      homeMode = "755";
      description = "Rishabh Singh";
      extraGroups = [
        "networkmanager" "wheel" "libvirtd" "scanner" "lp"
        "usbguard" "plugdev" "adbusers" "docker" "kvm"
        "qemu-libvirtd" "sambashare"
      ];
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [ ];
    };
    "kodi" = {
      isNormalUser = true;
      description = "Kodi Media Center User";
    };
  };

  # ... (services.udev.extraRules definition remains the same) ...
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", MODE="0664", GROUP="plugdev"
  '';


  # === USBGuard Service Configuration ===
  # IMPORTANT: Ensure usbguard service is enabled elsewhere in your configuration:
  # services.usbguard.enable = true; # MUST be set somewhere!

  # Configure usbguard options directly under services.usbguard
  services.usbguard = {
    # --- IPC Access Control ---
    # Defines who can talk to the usbguard daemon via D-Bus/IPC.
    # Crucial for tools like 'better-control'.
    IPCAllowedUsers = [ primaryUser ];   # Correct: Direct attribute
    IPCAllowedGroups = [ "usbguard" ]; # Correct: Direct attribute

    # --- Default Policy Settings (Examples - Set directly if needed) ---
    # Defines how usbguard behaves by default. Uncomment and set if you want
    # to override the defaults explicitly.
    # ImplicitPolicyTarget = "block"; # Default: Block devices not matching any rule. Recommended.
    # PresentDevicePolicy = "apply-policy"; # Default: Check devices present at start against rules.
    # InsertedDevicePolicy = "apply-policy"; # Default: Check newly inserted devices against rules.
    # RestoreControllerDeviceState = false; # Default: Don't try to restore state on start.

    # --- Rules Definition (Example) ---
    # Define authorization rules here if not using a separate ruleFile.
    # rules = ''
    #   allow id vendor:product name "My Keyboard"
    #   allow id other_vendor:other_product
    # '';
  };


  # ... (nix.settings.allowed-users, location.provider, services.geoclue2 definitions remain the same) ...
  nix.settings.allowed-users = [ "@wheel" primaryUser ];
  location.provider = "geoclue2";
  services.geoclue2.enable = true;

}