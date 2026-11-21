{ inputs, ... }:
{
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
  ];

  programs.caelestia = {
    enable = true;

    systemd = {
      enable = true;
      # Hyprland's Home Manager module starts this target on login.
      target = "hyprland-session.target";
      environment = [
        "QT_QPA_PLATFORMTHEME=gtk3"
      ];
    };

    settings = {
      general.apps = {
        terminal = [ "kitty" ];
        audio = [ "pwvucontrol" ];
        playback = [ "mpv" ];
        explorer = [ "thunar" ];
      };

      appearance.font = {
        headline.family = "Rubik";
        title.family = "Rubik";
        body.family = "Rubik";
        label.family = "Rubik";
        mono.family = "CaskaydiaCove NF";
      };

      bar.statusIcons = [
        { id = "lockStatus"; enabled = false; }
        { id = "audio"; enabled = true; }
        { id = "microphone"; enabled = false; }
        { id = "kbLayout"; enabled = false; }
        { id = "network"; enabled = true; }
        { id = "bluetooth"; enabled = true; }
        { id = "battery"; enabled = true; }
      ];

      utilities.quickToggles = [
        { id = "wifi"; enabled = true; }
        { id = "bluetooth"; enabled = true; }
        { id = "mic"; enabled = true; }
        { id = "settings"; enabled = true; }
        { id = "dnd"; enabled = true; }
      ];

      paths.wallpaperDir = "~/Pictures/Wallpapers";

      services.defaultPlayer = "Spotify";
    };

    cli = {
      enable = true;
      settings.theme = {
        enableGtk = true;
        enableQt = true;
        enableFuzzel = true;
        enableBtop = true;
        enableCava = true;
      };
    };
  };
}
