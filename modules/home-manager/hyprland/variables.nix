let
  waybarStyle = "slickbar"; # simplebar, slickbar, or default
in
{
  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "Rishabh5321";
  gitEmail = "rishabh98818@outlook.com";

  # Hyprland Settings
  extraMonitorSettings = "";

  flakeDir = "/home/rishabh/nix-dotfiles";

  # Waybar Settings
  clock24h = false;

  # Program Options
  browser = "firefox"; # Set Default Browser (google-chrome-stable for google-chrome)
  terminal = "alacritty"; # Set Default System Terminal

  theShell = "zsh";
  host = "dell";

  alacritty = true;

  wallpaperDir = "~/Pictures/Wallpapers";

  slickbar =
    if waybarStyle == "slickbar"
    then true
    else false;
  simplebar =
    if waybarStyle == "simplebar"
    then true
    else false;
  bar-number = true;

  wezterm = true;
}
