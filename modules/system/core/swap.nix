_: {
  # ===== ZRAM SWAP CONFIGURATION =====
  # ZRAM creates compressed swap space in RAM for better performance
  # than traditional disk-based swap
  zramSwap = {
    enable = true;

    # Use zstd compression algorithm for optimal balance of speed and compression ratio
    algorithm = "zstd";

    # Allocate 50% of total RAM for compressed swap (4GB out of 8GB RAM)
    # This provides effective swap space while leaving enough RAM for normal operations
    memoryPercent = 50;

    # High priority ensures zram swap is preferred over disk swap
    # Lower numbers = higher priority (100 is high priority)
    priority = 100;

    # Number of parallel zram devices to create
    # Using 4 devices allows parallel compression/decompression
    # Rule of thumb: use half the number of CPU cores for optimal performance
    swapDevices = 4;
  };
}
