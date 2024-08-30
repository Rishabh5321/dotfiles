_: {
  # Bluetooth Support
  hardware.bluetooth.enable = true;
  #hardware.bluetooth.powerOnBoot = true;
  #services.blueman.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
}
