_:
{
  services.displayManager.ly = {
    enable = true;
    settings = {
      auth_fails = 3;
      hide_version_string = true;
      hide_key_hints = true;
      clear_password = true;
      bg = "0x00555555";
      fg = "0x00ffffff";
      border_fg = "0x00ffffff";
      error_bg = "0x00555555";
      animation = "colormix";
      colormix_col1 = "0x00aaaaaa";
      colormix_col2 = "0x00555555";
      colormix_col3 = "0x00000000";
    };
  };
  boot.kernelParams = [ "consoleblank=60" ];
}
