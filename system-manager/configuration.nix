{ pkgs
, system
, ...
}:

{
  imports = [
    ../modules/system/packages/nix_settings.nix
    # ./modules/pam.nix
  ];

  config = {
    nixpkgs.hostPlatform = system;
    system-manager.allowAnyDistro = true;

    environment.systemPackages = with pkgs; [
      gh
    ];

    # system-manager.pam = {
    #   enable = true;
    #   services = [ "hyprlock" "swaylock" ];
    # };
  };
}
