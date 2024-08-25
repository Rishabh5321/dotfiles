{pkgs, ...}: {
  # OpenGL
  hardware.graphics = {
    enable = true;
    #extraPackages = with pkgs; [vaapiIntel vaapiVdpau libvdpau-va-gl libvdpau-va-gl];
    enable32Bit = true;
  };
}
