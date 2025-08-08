# Modern, beautiful starship configuration
{ config
, lib
, ...
}:
let
  # Enhanced color palette
  accent = "#${config.lib.stylix.colors.base0D}";
  urgent = "#${config.lib.stylix.colors.base08}";
  success = "#${config.lib.stylix.colors.base0B}";
  warning = "#${config.lib.stylix.colors.base0A}";
  muted = "#${config.lib.stylix.colors.base03}";
in
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

      # Modern format with clean visual separation
      format = lib.concatStrings [
        "╭─"
        "$nix_shell"
        "$container"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_status"
        "$git_state"
        "$package"
        "$nodejs"
        "$python"
        "$rust"
        "$golang"
        "$java"
        "$docker_context"
        "$kubernetes"
        "$aws"
        "$fill"
        "$cmd_duration"
        "$time"
        "\n"
        "╰─$character"
      ];

      # Elegant right-side alignment for metadata
      fill = {
        symbol = "─";
        style = "bold ${muted}";
      };

      # Modern directory styling
      directory = {
        style = "bold ${accent}";
        truncation_length = 4;
        truncate_to_repo = true;
        home_symbol = "󰋜 ";
        read_only = " 󰌾";
        read_only_style = "${urgent}";
        format = "[$path]($style)[$read_only]($read_only_style) ";
      };

      # Refined character indicators
      character = {
        success_symbol = "[❯](bold ${success})";
        error_symbol = "[❯](bold ${urgent})";
        vimcmd_symbol = "[❮](bold cyan)";
      };

      # Clean hostname display
      hostname = {
        ssh_only = false;
        format = "[$ssh_symbol$hostname]($style) ";
        ssh_symbol = "󰢩 ";
        style = "bold ${accent}";
        disabled = false;
      };

      # Stylish Nix shell indicator
      nix_shell = {
        format = "[$symbol$state]($style) ";
        symbol = "❄️ ";
        pure_msg = "pure";
        impure_msg = "impure";
        unknown_msg = "nix";
        style = "bold blue";
      };

      # Modern Git branch styling
      git_branch = {
        symbol = " ";
        style = "bold ${accent}";
        format = "[$symbol$branch]($style) ";
        truncation_length = 20;
        truncation_symbol = "…";
      };

      # Enhanced Git status with better symbols
      git_status = {
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
        style = "${warning}";
        ahead = "⇡$count ";
        behind = "⇣$count ";
        up_to_date = "";
        conflicted = "󰞇 $count ";
        untracked = "? $count ";
        modified = "󰏫 $count ";
        staged = "󰐗 $count ";
        renamed = "󰑕 $count ";
        deleted = "󰍶 $count ";
        stashed = "󰏗 $count ";
      };

      # Git state with modern styling
      git_state = {
        format = "([$state( $progress_current/$progress_total)]($style) )";
        style = "bold ${warning}";
        rebase = "REBASING";
        merge = "MERGING";
        revert = "REVERTING";
        cherry_pick = "CHERRY-PICKING";
        bisect = "BISECTING";
        am = "AM";
        am_or_rebase = "AM/REBASE";
      };

      # Package version display
      package = {
        format = "[$symbol$version]($style) ";
        symbol = "󰏖 ";
        style = "bold ${muted}";
        disabled = false;
      };

      # Language-specific modules with consistent styling
      nodejs = {
        format = "[$symbol$version]($style) ";
        symbol = " ";
        style = "bold green";
        detect_extensions = [ "js" "mjs" "cjs" "ts" "mts" "cts" ];
      };

      python = {
        format = "[$symbol$pyenv_prefix$version( $virtualenv)]($style) ";
        symbol = " ";
        style = "bold yellow";
        pyenv_version_name = true;
        pyenv_prefix = "pyenv ";
      };

      rust = {
        format = "[$symbol$version]($style) ";
        symbol = " ";
        style = "bold red";
      };

      golang = {
        format = "[$symbol$version]($style) ";
        symbol = " ";
        style = "bold cyan";
      };

      java = {
        format = "[$symbol$version]($style) ";
        symbol = " ";
        style = "bold red";
      };

      # Container and deployment context
      container = {
        format = "[$symbol \\[$name\\]]($style) ";
        symbol = "⬢";
        style = "bold ${warning}";
      };

      docker_context = {
        format = "[$symbol$context]($style) ";
        symbol = " ";
        style = "bold blue";
        only_with_files = true;
      };

      kubernetes = {
        format = "[$symbol$context( \\($namespace\\))]($style) ";
        symbol = "☸ ";
        style = "bold blue";
        disabled = false;
      };

      aws = {
        format = "[$symbol$profile( \\($region\\))]($style) ";
        symbol = "󰸏 ";
        style = "bold ${warning}";
      };

      # Command duration with modern styling
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "bold ${muted}";
        min_time = 2000;
        show_milliseconds = true;
      };

      # Optional time display
      time = {
        format = "[$time]($style)";
        style = "bold ${muted}";
        time_format = "%H:%M";
        disabled = false;
      };

      # Additional modern touches
      username = {
        format = "[$user]($style) ";
        style_user = "bold ${accent}";
        style_root = "bold ${urgent}";
        show_always = false;
      };

      sudo = {
        format = "[as $symbol]($style) ";
        symbol = "🧙";
        style = "bold ${urgent}";
        disabled = false;
      };

      # Status module for exit codes
      status = {
        format = "[$symbol$status]($style) ";
        symbol = "✗ ";
        success_symbol = "";
        not_executable_symbol = "🚫 ";
        not_found_symbol = "🔍 ";
        sigint_symbol = "🧱 ";
        signal_symbol = "⚡ ";
        style = "bold ${urgent}";
        disabled = false;
      };
    };
  };
}
