{ pkgs, pkgs-unstable, ... }: {
  # OpenGL
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs-unstable; [
      vpl-gpu-rt
    ];
    #enable32Bit = true;
    driSupport32Bit = true;
  };
}
