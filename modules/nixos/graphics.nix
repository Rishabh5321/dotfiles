{pkgs, ...}: {
  # OpenGL
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
    ];
    #enable32Bit = true;
    enable32Bit = true;
  };
}
