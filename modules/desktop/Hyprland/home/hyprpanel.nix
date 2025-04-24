{ pkgs, inputs, ... }:
{
  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
    #inputs.ags.homeManagerModules.default
  ];
  home.packages = with pkgs; [
    power-profiles-daemon
    jq
    vulnix
    pavucontrol
    pulseaudio
    brightnessctl
    btop
    gcolor3
  ];
  # programs.ags = {
  #   enable = true;
  # };
  programs.hyprpanel = {
    enable = true;
    overwrite.enable = true;
    hyprland.enable = true;
    settings = {
      layout = {
        "bar.layouts" =
          let
            layout =
              {
                showBattery ? true,
              }:
              {
                "left" = [
                  "dashboard"
                  "workspaces"
                  "windowtitle"
                  "updates"
                  "storage"
                ] ++ (if showBattery then [ "battery" ] else [ ]);
                "middle" = [
                  "media"
                ];
                "right" = [
                  "cpu"
                  "ram"
                  "volume"
                  "network"
                  "bluetooth"
                  "systray"
                  "clock"
                  "notifications"
                ];
              };
            none = {
              "left" = [ ];
              "middle" = [ ];
              "right" = [ ];
            };
          in
          {
            "0" = layout { };
            "1" = none;
            "2" = layout { showBattery = false; };
            "3" = none;
          };
      };
      bar.customModules.updates.pollingInterval = 1440000;
      theme.name = "catppuccin_mocha";
      theme.bar.floating = false;
      theme.bar.buttons.enableBorders = true;
      theme.bar.transparent = true;
      theme.font.size = "14px";
      menus.clock.time.military = true;
      menus.clock.time.hideSeconds = false;
      bar.clock.format = "%y/%m/%d  %H:%M";
      bar.media.show_active_only = true;
      bar.notifications.show_total = false;
      theme.bar.buttons.modules.ram.enableBorder = false;
      bar.launcher.autoDetectIcon = true;
      bar.battery.hideLabelWhenFull = true;
      menus.dashboard.controls.enabled = false;
      menus.dashboard.shortcuts.enabled = true;
      menus.clock.weather.enabled = false;
      menus.dashboard.shortcuts.right.shortcut1.command = "${pkgs.gcolor3}/bin/gcolor3";
      menus.media.displayTime = true;
      menus.power.lowBatteryNotification = true;
      bar.customModules.updates.updateCommand = "jq '[.[].cvssv3_basescore | to_entries | add | select(.value > 5)] | length' <<< $(vulnix -S --json)";
      bar.customModules.updates.icon.updated = "󰋼";
      bar.customModules.updates.icon.pending = "󰋼";
      bar.volume.rightClick = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      bar.volume.middleClick = "pavucontrol";
      bar.media.format = "{title}";
    };
  };
}
