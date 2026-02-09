{ pkgs
, system
, ...
}:

{
  config = {
    nixpkgs.hostPlatform = system;
    system-manager.allowAnyDistro = true;

    environment.systemPackages = with pkgs; [
      gh
    ];
  };
}
