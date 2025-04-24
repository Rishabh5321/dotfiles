# *.nix
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];

  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    theme = "catppuccin_mocha";
    layout = {
      "bar.layouts" = {
        "0" = {
          left = ["dashboard" "windowtitle" "systray" "ram" "netstat"];
          middle = ["workspaces"];
          right = ["cava" "media" "clock" "hypridle" "power"];
        };
      };
    };
    override = {
      "theme.bar.buttons.workspaces.hover" = "#7f849c";
      "theme.bar.buttons.workspaces.active" = "#f5c2e7";
      "theme.bar.buttons.workspaces.occupied" = "#89dceb";
      "theme.bar.buttons.workspaces.available" = "#585b70";
      "theme.bar.buttons.workspaces.border" = "#f9e2af";
      "theme.bar.buttons.modules.power.spacing" = "0em";
      "theme.bar.border.color" = "#f9e2af";
      "theme.osd.orientation" = "vertical";
      "theme.osd.location" = "right";
      "bar.windowtitle.leftClick" = "pkill rofi || /nix/store/rsb5ihbh4m3q4x046vc0y1r301i8j3is-ags-1.8.2/bin/ags -t overview";
      "bar.workspaces.spacing" = "1.5";
      "bar.customModules.cava.showIcon"= false;
      "theme.font.name" = "JetBrainsMono Nerd Font";
    };
    settings = {
      bar.autoHide = "fullscreen";
      notifications.position = "top";
      #bar.windowtitle.leftClick = "'pkill rofi||/nix/store/rsb5ihbh4m3q4x046vc0y1r301i8j3is-ags-1.8.2/bin/ags -t overview'";
      theme.bar.buttons.workspaces.spacing = "0.5";
      theme.bar.buttons.background_hover_opacity = 80;
      theme.bar.buttons.innerRadiusMultiplier = "0.4";
      theme.bar.buttons.radius = "1.0em";
      theme.bar.buttons.y_margins = "0.5em";
      theme.bar.buttons.padding_y = "0.1rem";
      theme.bar.buttons.padding_x = "0.7rem";
      theme.bar.buttons.spacing = "0.25em";
      theme.bar.border.location = "none";
      theme.bar.buttons.workspaces.enableBorder = true;
      theme.bar.buttons.modules.power.enableBorder = true;
      theme.bar.buttons.dashboard.enableBorder = true;
      theme.bar.border.width = "0.1em";
      theme.bar.outer_spacing = "1.0em";
      theme.bar.label_spacing = "0.5em";
      theme.bar.border_radius = "0.6em";
      theme.bar.margin_sides = "2.5em";
      theme.bar.margin_bottom = "0em";
      theme.bar.margin_top = "0.5em";
      theme.bar.layer = "overlay";
      theme.bar.opacity = 90;
      theme.bar.scaling = 85;
      theme.osd.scaling = 80;
      theme.tooltip.scaling = 80;
      theme.notification.scaling = 80;
      theme.bar.menus.menu.battery.scaling = 80;
      theme.bar.menus.menu.bluetooth.scaling = 80;
      theme.bar.menus.menu.clock.scaling = 80;
      #theme.bar.menus.menu.dashboard.confirmation_scaling = 80;
      theme.bar.menus.menu.dashboard.scaling = 70;
      theme.bar.menus.menu.dashboard.confirmation_scaling = 80;
      theme.bar.menus.menu.media.scaling = 80;
      theme.bar.menus.menu.notifications.scaling = 80;
      theme.bar.menus.menu.volume.scaling = 80;
      theme.bar.menus.popover.scaling = 80;
      theme.bar.location = "top";
      theme.bar.buttons.workspaces.pill.radius = "0.3rem * 0.2";
      theme.bar.buttons.workspaces.pill.height = "4em";
      theme.bar.buttons.workspaces.pill.width = "5em";
      theme.bar.buttons.workspaces.pill.active_width = "12em";
      menus.dashboard.directories.left.directory1.command = "bash -c \"xdg-open $HOME/Downloads/\"";
      menus.dashboard.directories.left.directory1.label = "󰉍 Downloads";
      menus.dashboard.directories.left.directory2.command = "bash -c \"xdg-open $HOME/Videos/\"";
      menus.dashboard.directories.left.directory2.label = "󰉏 Videos";
      menus.dashboard.directories.left.directory3.command = "bash -c \"xdg-open $HOME/Projects/\"";
      menus.dashboard.directories.left.directory3.label = "󰚝 Projects";
      menus.dashboard.directories.right.directory1.command = "bash -c \"xdg-open $HOME/Documents/\"";
      menus.dashboard.directories.right.directory1.label = "󱧶 Documents";
      menus.dashboard.directories.right.directory2.command = "bash -c \"xdg-open $HOME/Pictures/\"";
      menus.dashboard.directories.right.directory2.label = "󰉏 Pictures";
      menus.dashboard.directories.right.directory3.command = "bash -c \"xdg-open $HOME/\"";
      menus.dashboard.directories.right.directory3.label = "󱂵 Home";
      bar.customModules.updates.pollingInterval = 1440000;
      bar.launcher.icon = "❄️";
      theme.bar.floating = true;
      theme.bar.buttons.enableBorders = true;
      bar.clock.format = "%y/%m/%d  %H:%M";
      bar.media.show_active_only = false;
      bar.notifications.show_total = true;
      bar.windowtitle.leftClick = " pkill rofi || /nix/store/rsb5ihbh4m3q4x046vc0y1r301i8j3is-ags-1.8.2/bin/ags -t overview";
      theme.bar.buttons.modules.ram.enableBorder = false;
      bar.battery.hideLabelWhenFull = true;
      menus.dashboard.controls.enabled = true;
      menus.dashboard.shortcuts.enabled = true;
      menus.dashboard.shortcuts.right.shortcut1.command = "gcolor3";
      menus.media.displayTime = true;
      menus.power.lowBatteryNotification = true;
      bar.customModules.updates.updateCommand = "jq '[.[].cvssv3_basescore | to_entries | add | select(.value > 5)] | length' <<< $(vulnix -S --json)";
      bar.customModules.updates.icon.updated = "󰋼";
      bar.customModules.updates.icon.pending = "󰋼";
      bar.volume.rightClick = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      bar.volume.middleClick = "pavucontrol";
      bar.media.format = "{title}";
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = false;
      bar.workspaces.ignored = "[-99]";
      theme.font.name = "JetBrainsMono Nerd Font";
      theme.font.size = "1.1rem";
      bar.workspaces.monitorSpecific = false;
      bar.workspaces.workspaces = 5;
      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };
      menus.dashboard.directories.enabled = true;
      menus.dashboard.stats.enable_gpu = false;
      theme.bar.transparent = false;
    };
  };
}
