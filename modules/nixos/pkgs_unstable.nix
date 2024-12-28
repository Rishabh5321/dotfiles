{ pkgs-unstable, inputs, ... }: {
  environment.systemPackages = with pkgs-unstable; [
    gamescope
    inputs.alejandra.defaultPackage.${system}
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge
    inputs.zen-browser.packages."${system}".default
    stremio
    vscode
    winetricks
    zed-editor
  ];
}
