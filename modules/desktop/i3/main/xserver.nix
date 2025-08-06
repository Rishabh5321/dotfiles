{ ... }:

{
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    xkb = {
      layout = "us";
      # options = "grp:alt_shift_toggle";
    };
  };
}
