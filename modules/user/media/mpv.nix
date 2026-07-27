{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    config = {
      save-position-on-quit = "yes";
      save-watch-history = true;
      keep-open = true;
      screenshot-format = "png";
      screenshot-directory = "~/Pictures/Screenshots/";
      cache-secs = 300;
      volume = 30;
      ytdl-format = "bestvideo[height>=?720]+bestaudio/best";
      sub-scale = "0.5";
    };

    scripts = with pkgs; [
      mpvScripts.autosub
      mpvScripts.mpv-cheatsheet-ng
      mpvScripts.uosc
      mpvScripts.thumbfast
    ];

  };
}
