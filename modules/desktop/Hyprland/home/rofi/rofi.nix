{ pkgs
, config
, wallpaper
, ...
}: {
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      extraConfig = {
        modi = "drun,filebrowser,run";
        show-icons = true;
        icon-theme = "Papirus";
        font = "JetBrainsMono Nerd Font Mono 12";
        drun-display-format = "{icon} {name}";
        display-drun = " Apps";
        display-run = " Run";
        display-filebrowser = " File";
      };
      theme =
        let
          inherit (config.lib.formats.rasi) mkLiteral;
        in
        {
          "*" = {
            bg = mkLiteral "#${config.stylix.base16Scheme.base00}";
            bg-alt = mkLiteral "#${config.stylix.base16Scheme.base09}";
            foreground = mkLiteral "#${config.stylix.base16Scheme.base01}";
            selected = mkLiteral "#${config.stylix.base16Scheme.base08}";
            active = mkLiteral "#${config.stylix.base16Scheme.base0B}";
            text-selected = mkLiteral "#${config.stylix.base16Scheme.base00}";
            text-color = mkLiteral "#${config.stylix.base16Scheme.base05}";
            border-color = mkLiteral "#${config.stylix.base16Scheme.base0F}";
            urgent = mkLiteral "#${config.stylix.base16Scheme.base0E}";
          };
          "window" = {
            transparency = "real";
            width = mkLiteral "1000px";
            location = mkLiteral "center";
            anchor = mkLiteral "center";
            fullscreen = false;
            x-offset = mkLiteral "0px";
            y-offset = mkLiteral "0px";
            cursor = "default";
            enabled = true;
            border-radius = mkLiteral "15px";
            background-color = mkLiteral "@bg";
          };
          "mainbox" = {
            enabled = true;
            spacing = mkLiteral "0px";
            orientation = mkLiteral "horizontal";
            children = map mkLiteral [
              "imagebox"
              "listbox"
            ];
            background-color = mkLiteral "transparent";
          };
          "imagebox" = {
            padding = mkLiteral "20px";
            background-color = mkLiteral "transparent";
            background-image = mkLiteral ''url("~/Pictures/Wallpapers/${wallpaper}",height)'';
            orientation = mkLiteral "vertical";
            children = map mkLiteral [
              "inputbar"
              "dummy"
              "mode-switcher"
            ];
          };
          "listbox" = {
            spacing = mkLiteral "20px";
            padding = mkLiteral "20px";
            background-color = mkLiteral "transparent";
            orientation = mkLiteral "vertical";
            children = map mkLiteral [
              "message"
              "listview"
            ];
          };
          "dummy" = {
            background-color = mkLiteral "transparent";
          };
          "inputbar" = {
            enabled = true;
            spacing = mkLiteral "10px";
            padding = mkLiteral "10px";
            border-radius = mkLiteral "10px";
            background-color = mkLiteral "@bg-alt";
            text-color = mkLiteral "@foreground";
            children = map mkLiteral [
              "textbox-prompt-colon"
              "entry"
            ];
          };
          "textbox-prompt-colon" = {
            enabled = true;
            expand = false;
            str = "";
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
          };
          "entry" = {
            enabled = true;
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "text";
            placeholder = "Search";
            placeholder-color = mkLiteral "inherit";
          };
          "mode-switcher" = {
            enabled = true;
            spacing = mkLiteral "20px";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@foreground";
          };
          "button" = {
            padding = mkLiteral "15px";
            border-radius = mkLiteral "10px";
            background-color = mkLiteral "@bg-alt";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "pointer";
          };
          "button selected" = {
            background-color = mkLiteral "@selected";
            text-color = mkLiteral "@foreground";
          };
          "listview" = {
            enabled = true;
            columns = 1;
            lines = 8;
            cycle = true;
            dynamic = true;
            scrollbar = false;
            layout = mkLiteral "vertical";
            reverse = false;
            fixed-height = true;
            fixed-columns = true;
            spacing = mkLiteral "10px";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@foreground";
            cursor = "default";
          };
          "element" = {
            enabled = true;
            spacing = mkLiteral "15px";
            padding = mkLiteral "8px";
            border-radius = mkLiteral "10px";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@text-color";
            cursor = mkLiteral "pointer";
          };
          "element normal.normal" = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "@text-color";
          };
          "element normal.urgent" = {
            background-color = mkLiteral "@urgent";
            text-color = mkLiteral "@text-color";
          };
          "element normal.active" = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "@text-color";
          };
          "element selected.normal" = {
            background-color = mkLiteral "@selected";
            text-color = mkLiteral "@foreground";
          };
          "element selected.urgent" = {
            background-color = mkLiteral "@urgent";
            text-color = mkLiteral "@text-selected";
          };
          "element selected.active" = {
            background-color = mkLiteral "@urgent";
            text-color = mkLiteral "@text-selected";
          };
          "element-icon" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            size = mkLiteral "36px";
            cursor = mkLiteral "inherit";
          };
          "element-text" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
          "message" = {
            background-color = mkLiteral "transparent";
          };
          "textbox" = {
            padding = mkLiteral "15px";
            border-radius = mkLiteral "10px";
            background-color = mkLiteral "@bg-alt";
            text-color = mkLiteral "@foreground";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
          "error-message" = {
            padding = mkLiteral "15px";
            border-radius = mkLiteral "20px";
            background-color = mkLiteral "@bg";
            text-color = mkLiteral "@foreground";
          };
        };
    };
  };
}
