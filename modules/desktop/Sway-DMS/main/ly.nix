_:

{
  # 1. Enable the Ly display manager
  services.displayManager.ly.enable = true;

  # 2. Add the consoleblank timer to the kernel parameters
  boot.kernelParams = [ "consoleblank=60" ];
}
