{ pkgs, ... }: {
  # OpenGL
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-media-driver
      intel-ocl
      libvdpau-va-gl
      vaapiIntel
      vaapiVdpau
    ];
    #enable32Bit = true;
    enable32Bit = true;
  };
}
