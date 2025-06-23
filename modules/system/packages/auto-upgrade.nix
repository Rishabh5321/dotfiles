{ inputs, ... }: {
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "8:30";
    #randomizedDelaySec = "45min";
  };
}
