{ pkgs, ... }: {
  services.hypridle = {
    enable = true;
    package = pkgs.hypridle;
    settings = {
      general = {
        lock_cmd = "dms ipc call lock lock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "niri msg action power-off-monitors";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "if ! pactl list sink-inputs | grep -q 'Corked: no'; then niri msg action power-off-monitors; fi";
        }
        {
          timeout = 320;
          on-timeout = "if ! pactl list sink-inputs | grep -q 'Corked: no'; then loginctl lock-session; fi";
        }
      ];
    };
  };
}
