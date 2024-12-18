_: {
  #sound.enable = true;
  hardware.pulseaudio.enable = false;

  # make pipewire realtime-capable
  security.rtkit.enable = true;

  # pipewire low latency
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
}
