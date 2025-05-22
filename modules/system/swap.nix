_: {
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;  # 50% of your 8GB RAM (4GB)
    priority = 100;      # High priority for swap
    swapDevices = 4;     # Half the number of cores is a good balance
  };
}
