{ pkgs-unstable, ... }: {
  # OpenGL
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs-unstable; [
      vpl-gpu-rt
    ];
    driSupport32Bit = true;
  };
}
