{ pkgs
, system
, ...
}:

{
  imports = [
    ../modules/system/packages/nix_settings.nix
  ];

  config = {
    nixpkgs.hostPlatform = system;
    system-manager.allowAnyDistro = true;

    environment.systemPackages = with pkgs; [
      gh
    ];
  };
}
