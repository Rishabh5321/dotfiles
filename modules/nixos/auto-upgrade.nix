{ inputs, ... }: {
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "-L" # print build logs
    ];
    dates = "9:40";
    #randomizedDelaySec = "45min";
  };
}