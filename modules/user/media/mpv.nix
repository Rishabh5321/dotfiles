{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    config = {
      save-position-on-quit = "yes";
      keep-open = true;
      screenshot-format = "png";
      screenshot-directory = "~/Pictures/Screenshots/";
      volume = 30;
      sub-scale = "0.5";
      ytdl-format = "bestvideo[height<=?720]+bestaudio/best";

      # --- Stream Startup Optimizations ---
      cache-pause-initial = "no";
      cache-pause = "no";
      hwdec = "auto-safe";
      ytdl-raw-options = "no-check-certificates=,no-warnings=,fast-queries=";

      # --- Aggressive Caching (100% of video) ---
      cache = "yes";

      # Remove the time limit (set to ~24 hours) so it doesn't stop after 300s
      cache-secs = 86400;

      # Allocate up to 2GB of RAM for the forward cache (unwatched parts)
      demuxer-max-bytes = "2048MiB";

      # Allocate up to 1GB of RAM for the backward cache (so seeking back doesn't re-download)
      demuxer-max-back-bytes = "1024MiB";

      # OPTIONAL: If you don't want to use up to 3GB of your laptop's RAM for caching,
      # uncomment the two lines below to cache to your SSD instead.
      cache-on-disk = "yes";
      cache-dir = "~/.cache/mpv";
    };
  };
}
