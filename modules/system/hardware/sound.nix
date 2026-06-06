{ pkgs, ... }:
{
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true; # Crucial: Explicitly enable the session manager

    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 256;
        "default.clock.min-quantum" = 32; # Allow it to drop for extreme low latency
        "default.clock.max-quantum" = 8192; # CRITICAL: Allow large buffers for Bluetooth
      };
    };

    extraConfig.pipewire-pulse."92-low-latency" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.min.req = "32/48000";
            pulse.default.req = "256/48000";
            pulse.max.req = "8192/48000";
            pulse.min.quantum = "32/48000";
            pulse.max.quantum = "8192/48000";
          };
        }
      ];
    };
  };

  hardware.alsa.enablePersistence = true;
  environment.systemPackages = with pkgs; [ pulseaudioFull ];
}
