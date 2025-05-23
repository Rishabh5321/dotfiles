{ inputs
, pkgs
, ...
}: {
  imports = [ inputs.nvchad4nix.homeManagerModule ];
  programs.nvchad = {
    enable = true;
    extraPackages = with pkgs; [
      nixd
    ];
    hm-activation = true;
    backup = false;
  };
}
