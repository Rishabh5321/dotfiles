{ username
, wallpaper
, lib
, ...
}: {
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
        export MAKEFLAGS="$MAKEFLAGS -j$(($(nproc)-1))"
      fi
      bindkey '^[[3~' delete-char                     # Key Del
      bindkey '^[[5~' beginning-of-buffer-or-history  # Key Page Up
      bindkey '^[[6~' end-of-buffer-or-history        # Key Page Down
      bindkey '^[[1;3D' backward-word                 # Key Alt + Left
      bindkey '^[[1;3C' forward-word                  # Key Alt + Right
      bindkey '^[[H' beginning-of-line                # Key Home
      bindkey '^[[F' end-of-line                      # Key End
      fastfetch
      if [ -f $HOME/.zshrc-personal ]; then
        source $HOME/.zshrc-personal
      fi
    '';

    shellAliases = {
      # record = "wf-recorder --audio=alsa_output.pci-0000_08_00.6.analog-stereo.monitor -f $HOME/Videos/$(date +'%Y%m%d%H%M%S_1.mp4')";

      # Utils
      c = "clear";
      cd = "z";
      tt = "gtrash put";
      nano = "micro";
      #code = "vscode";
      py = "python";
      icat = "kitten icat";
      dsize = "du -hs";
      findw = "grep -rl";

      l = "eza"; # EZA_ICON_SPACING=2
      ll = "eza -a -long";
      tree = "eza --icons --tree --group-directories-first";

      # Nixos
      cdnix = "cd ~/dotfiles && code ~/dotfiles";
      # Remove or comment out the problematic alias:
      # nix-shell = "nix-shell --run zsh";
      # You can keep this one if you like, but understand it runs zsh *within* the shell, not enter it interactively:
      # ns = "nix-shell --run zsh";

      nix-switch = "cd ~/dotfiles && nh os switch ~/dotfiles";
      nix-switchg = "cd ~/dotfiles && git pull && nh os switch ~/dotfiles";
      nix-switchu = "cd ~/dotfiles && git pull && nh os switch -u ~/dotfiles";
      #nix-flake-update = "sudo nix flake update ~/dotfiles#";
      wallswitch = "swww img /home/${username}/Pictures/Wallpapers/${wallpaper}";
      nix-clean = "sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/* && nix-collect-garbage && nix-collect-garbage -d";
      wallfetch = "cd ~/dotfiles && git fetch wallpaper && git subtree pull --prefix=wallpapers wallpaper main --squash && git push";

      # python
      piv = "python -m venv .venv";
      psv = "source .venv/bin/activate";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
