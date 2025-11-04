{ inputs, pkgs, ... }: {
  services.hypridle = {
    enable = true;
    package = inputs.hypridle.packages.${pkgs.system}.hypridle;
    settings = {
      general = {
        lock_cmd = "caelestia shell lock lock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "if ! pactl list sink-inputs | grep -q 'State: RUNNING'; then hyprctl dispatch dpms off; fi";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 320;
          on-timeout = "if ! pactl list sink-inputs | grep -q 'State: RUNNING'; then loginctl lock-session; fi";
        }
      ];
    };
  };
}
