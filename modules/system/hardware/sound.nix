{ inputs, ... }:
{
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    lowLatency = {
      # enable this module
      enable = true;
      # defaults (no need to be set unless modified)
      # quantum = 64;
      # rate = 48000;
    };
  };

  # make pipewire realtime-capable
  security.rtkit.enable = true;
}
