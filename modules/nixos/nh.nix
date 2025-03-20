{ pkgs
, username
, ...
}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
    flake = "/home/${username}/dotfiles";
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
