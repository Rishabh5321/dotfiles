_: {
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    priority = 999;
    swapDevices = 4; # Create 4 ZRAM devices (one per core)
  };
}
