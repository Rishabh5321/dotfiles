{ pkgs, ... }: {
  # OpenGL
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
    ];
    #enable32Bit = true;
    enable32Bit = true;
  };
}
