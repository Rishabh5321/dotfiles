# starship is a minimal, fast, and extremely customizable prompt for any shell!
{ config
, lib
, ...
}:
let
  accent = "#${config.lib.stylix.colors.base0D}";
  background-alt = "#${config.lib.stylix.colors.base01}";
  urgent = "#${config.lib.stylix.colors.base08}";
in
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "[╭─](white)"
        "$nix_shell"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "\n"
        "[╰─](white)$character"
      ];

      directory = {
        style = accent;
        truncation_length = 5;
        truncate_to_repo = true;
      };

      character = {
        success_symbol = "[❯](${accent})";
        error_symbol = "[❯](${urgent})";
        vimcmd_symbol = "[❮](cyan)";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname]($style) in ";
        style = "bold ${accent}";
        disabled = false;
      };

      nix_shell = {
        format = "[$symbol]($style) ";
        symbol = "❄️";
        style = "bold blue";
      };

      git_branch = {
        symbol = "";
        style = "bold ${accent}";
        format = "on [$symbol $branch]($style) ";
      };

      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218)($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "​";
        untracked = "​";
        modified = "​";
        staged = "​";
        renamed = "​";
        deleted = "​";
        stashed = "≡";
      };

      git_state = {
        format = "([$state( $progress_current/$progress_total)]($style)) ";
        style = "bright-black";
      };
    };
  };
}

