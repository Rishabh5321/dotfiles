{ pkgs, system, ... }:

{
  config = {
    nixpkgs.hostPlatform = system;

    environment.systemPackages = with pkgs; [
      btop
      ripgrep
      fd
      git
    ];



    # Example: Manage etc files
    # environment.etc."foo.conf".text = "bar";
  };
}
