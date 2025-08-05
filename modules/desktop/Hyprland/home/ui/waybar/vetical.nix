{ ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.top = {
      layer = "top";
      position = "left";
      margin = "5 2 5 0";
      reload_style_on_change = true;
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ ];
      modules-right = [ "pulseaudio" "clock" ];
      "hyprland/submap".format = "<b>{}</b>";
      "hyprland/workspaces".all-outputs = false;
      "custom/music" = { };
    };
  };
}
