{ pkgs, ... }:
{
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # lowLatency.enable = true;
  };
  hardware.alsa.enablePersistence = true;
  environment.systemPackages = with pkgs; [ pulseaudioFull ];

  # services.pulseaudio.enable = true;

  # services.pipewire.enable = false;

  # hardware.alsa.enablePersistence = true;

  # environment.systemPackages = with pkgs; [ pulseaudioFull ];

}
