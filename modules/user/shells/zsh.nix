{ username, wallpaper, lib, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "intheloop";
    };

    initContent = lib.mkBefore ''
      export PATH=$PATH:/run/current-system/sw/bin
      HISTFILE=~/.histfile
      HISTSIZE=1000
      SAVEHIST=1000

      setopt autocd nomatch
      unsetopt beep extendedglob notify

      autoload -Uz compinit
      compinit

      zstyle ":completion:*" menu select
      zstyle ":completion:*" matcher-list "" "m:{a-z0A-Z}={A-Za-z}" "r:|=*" "l:|=* r:|=*"

      if type nproc &>/dev/null; then
        export MAKEFLAGS="$MAKEFLAGS -j$(($(nproc) - 1))"
      fi

      bindkey '^[[3~' delete-char                     # Del
      bindkey '^[[5~' beginning-of-buffer-or-history  # Page Up
      bindkey '^[[6~' end-of-buffer-or-history        # Page Down
      bindkey '^[[1;3D' backward-word                 # Alt + Left
      bindkey '^[[1;3C' forward-word                  # Alt + Right
      bindkey '^[[H' beginning-of-line                # Home
      bindkey '^[[F' end-of-line                      # End

      fastfetch

      # Auto-start tmux if not already inside one
      # if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ -n "$PS1" ]; then
      #   tmux attach-session -t default || tmux new-session -s default
      # fi

      if [ -f $HOME/.zshrc-personal ]; then
        source $HOME/.zshrc-personal
      fi
    '';

    shellAliases = {
      # Utilities
      c = "clear";
      cd = "z";
      tt = "gtrash put";
      nano = "micro";
      py = "python";
      icat = "kitten icat";
      dsize = "du -hs";
      findw = "grep -rl";

      # Filesystem display
      l = "eza";
      ll = "eza -a -long";
      tree = "eza --icons --tree --group-directories-first";

      # NixOS
      cdnix = "cd ~/dotfiles && code ~/dotfiles";
      nix-switch = "cd ~/dotfiles && nh os switch ~/dotfiles";
      nix-switchg = "cd ~/dotfiles && git pull && nh os switch ~/dotfiles";
      nix-switchu = "cd ~/dotfiles && git pull && nh os switch -u ~/dotfiles";
      nix-clean = "sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/* && nix-collect-garbage && nix-collect-garbage -d";
      wallfetch = "cd ~/dotfiles && git fetch wallpaper && git subtree pull --prefix=wallpapers wallpaper main --squash && git push";
      wallswitch = "swww img /home/${username}/Pictures/Wallpapers/${wallpaper}";

      # Python
      piv = "python -m venv .venv";
      psv = "source .venv/bin/activate";
    };
  };
}
