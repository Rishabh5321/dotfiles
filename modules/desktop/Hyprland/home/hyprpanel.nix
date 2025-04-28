{ inputs, config, ... }:
let
  accent = "#${config.lib.stylix.colors.base0D}";
  accent-alt = "#${config.lib.stylix.colors.base03}";
  background = "#${config.lib.stylix.colors.base00}";
  background-alt = "#${config.lib.stylix.colors.base01}";
  foreground = "#${config.lib.stylix.colors.base05}";
  rounding = 18;
in
{
  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
  ];

  programs.hyprpanel = {
    # overlay.enable = false;
    enable = true;
    # systemd.enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    settings = {
      layout = {
        "bar.layouts" = {
          "0" = {
            "left" = [
              "dashboard"
              "workspaces"
              "windowtitle"
              "netstat"
            ];
            "middle" = [
              "clock"
              "media"
            ]; # Add this line
            "right" = [
              "battery"
              "volume"
              "bluetooth"
              "network"
              "systray"
              "notifications"
            ];
          };

          "1" = {
            "left" = [
              "dashboard"
              "workspaces"
              "windowtitle"
            ];
            "middle" = [
              "clock"
              "media"
            ];
            "right" = [
              "volume"
              "network"
              "systray"
              "notifications"
            ];
          };
        };
      };
    };

    override = {
      tear = true; # Screen Tearing
      scalingPriority = "hyprland";
      bar = {
        customModules.updates.pollingInterval = 1440000;
        launcher.icon = "";
        workspaces = {
          showAllActive = false;
          workspaces = 1;
          monitorSpecific = false;
          hideUnoccupied = true;
          showApplicationIcons = true;
          showWsIcons = true;
          ignored = "98";
        };
        windowtitle.label = false;
        clock.format = "%I:%M:%S %p";
        clock.showIcon = false;
        volume.label = true;
        bluetooth.label = false;
        network.label = true;
        media.show_active_only = true;
        network.truncation_size = 30;
      };
      menus.clock.weather.enable = false;
      wallpaper.enable = true;

      theme = {
        font.size = "0.85rem";
        bar.outer_spacing = "1rem";
        bar.dropdownGap = "2.3em";
        bar.menus.monochrome = true;
        bar.buttons.monochrome = true;
        bar.buttons.workspaces.hover = "${accent-alt}";
        bar.buttons.workspaces.active = "${accent}";
        bar.buttons.workspaces.available = "${accent-alt}";
        #bar.network.truncation_size = mkIntOption 7;
        bar.menus.background = "${background}";
        bar.menus.cards = "${background-alt}";
        bar.menus.card_radius = "${toString rounding}px";
        bar.menus.label = "${foreground}";
        bar.menus.text = "${foreground}";
        bar.menus.border.color = "${accent}";
        bar.menus.border.radius = "${toString rounding}px";
        bar.menus.popover.text = "${foreground}";
        bar.menus.popover.background = "${background-alt}";
        bar.menus.listitems.active = "${accent}";
        bar.menus.icons.active = "${accent}";
        bar.menus.switch.enabled = "${accent}";
        bar.menus.buttons.default = "${accent}";
        bar.menus.buttons.active = "${accent}";
        notification.border_radius = "${toString rounding}px";
        bar.menus.iconbuttons.active = "${accent}";
        bar.menus.progressbar.foreground = "${accent}";
        bar.menus.slider.primary = "${accent}";
        bar.menus.tooltip.background = "${background-alt}";
        bar.menus.tooltip.text = "${foreground}";
        bar.menus.dropdownmenu.background = "${background-alt}";
        bar.menus.dropdownmenu.text = "${foreground}";
        bar.background = "rgba(0, 0, 0, 0.3)";
        bar.buttons.text = "${foreground}";
        bar.buttons.radius = "${toString rounding}px";
        bar.buttons.background = "${background-alt}";
        bar.buttons.icon = "${accent}";
        bar.buttons.notifications.background = "${background-alt}";
        bar.buttons.hover = "${background}";
        bar.buttons.notifications.hover = "${background}";
        bar.buttons.notifications.total = "${accent}";
        bar.buttons.notifications.icon = "${accent}";
        notification.background = "${background-alt}";
        notification.actions.background = "${accent}";
        notification.actions.text = "${foreground}";
        notification.label = "${accent}";
        notification.border = "${background-alt}";
        notification.text = "${foreground}";
        notification.labelicon = "${accent}";
        osd.bar_color = "${accent}";
        osd.bar_overflow_color = "${accent-alt}";
        osd.icon = "${background}";
        osd.icon_container = "${accent}";
        osd.label = "${accent}";
        osd.bar_container = "${background-alt}";
        bar.menus.menu.media.background.color = "${background-alt}";
        bar.menus.menu.media.card.color = "${background-alt}";
        bar.menus.menu.media.card.tint = 90;
      };
    };
  };
}
