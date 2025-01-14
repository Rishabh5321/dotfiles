{ inputs, ... }: {
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "flake update"
      "nixpkgs"
      "-L" # print build logs
      "switch"
    ];
    dates = "08:20";
    #randomizedDelaySec = "45min";
  };
}
