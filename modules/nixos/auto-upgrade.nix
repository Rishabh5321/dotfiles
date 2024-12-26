{inputs, ...}:{
    system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
        "--update-input"
        "nixpkgs"
        "-L" # print build logs
    ];
    dates = "22:28";
    #randomizedDelaySec = "45min";
    };
}