{ pkgs, config, ... }:

{

  home.packages = [ pkgs.tmux-mem-cpu-load ];
  programs = {

    # MULTIPLEXER
    tmux = {
      enable = true;
      clock24 = true;

      plugins =

        with pkgs.tmuxPlugins; [
          better-mouse-mode
          # catppuccin
          # resurrect

          # yank
        ];
      sensibleOnTop = false;
      disableConfirmationPrompt = true;
      extraConfig =
        let
          background = "${config.lib.stylix.colors.base01}";
          foreground = "${config.lib.stylix.colors.base04}";

          r_arrow = { fg, bg }: ''#[fg=#${fg},bg=#${bg}]'';
          l_arrow = { fg, bg }: ''#[fg=#${fg},bg=#${bg}]'';

          color_1 = {
            fg = "${config.lib.stylix.colors.base00}";
            bg = "${config.lib.stylix.colors.base08}";
          };
          color_2 = {
            fg = "${config.lib.stylix.colors.base00}";
            bg = "${config.lib.stylix.colors.base0A}";
          };
          color_3 = {
            fg = "${config.lib.stylix.colors.base00}";
            bg = "${config.lib.stylix.colors.base0B}";
          };
          toString =
            { fg
            , bg
            , invert ? false
            ,
            }:
            if invert then ''fg=#${bg},bg=#${fg}'' else ''fg=#${fg},bg=#${bg}'';

          # WIDGETS

          current_window = "${
            l_arrow {
              fg = color_2.bg;
              bg = background;
            }
          }#[fg=#${background} bg=#${color_2.bg}] #I:#W ${
            r_arrow {
              fg = color_2.bg;
              bg = background;
            }
          }";

          icon = "#[${toString color_3}] 󱄅 ${
            r_arrow {
              fg = color_3.bg;
              bg = background;
            }
          }";

          cpu_mem_load = "${
            l_arrow {
              fg = color_1.bg;
              bg = background;
            }
          }#[${toString color_1}]#(tmux-mem-cpu-load --averages-count 0 --vertical-graph --graph-lines 10 --interval 2)  ";

          pane_title = "#{=25:pane_title}";

          clock = "${
            l_arrow {
              fg = color_2.bg;
              bg = color_1.bg;
            }
          }#[${toString color_2}] %H:%M | %d-%m-%Y ";

        in
        ''

          # keyMode = "vi";

          # Mouse works as expected
          set -g mouse on



          # start tab index at 1
          set -g base-index 1
          set -g pane-base-index 1
          set-window-option -g pane-base-index 1
          set-option -g renumber-windows on

          # AUTOMATIC REMANE
          setw -g automatic-rename on

          # open new panes in current dir
          bind '"' split-window -v -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"
          # new bind for horizontal split
          bind-key "|" split-window -h -c "#{pane_current_path}"
          bind-key "\\" split-window -fh -c "#{pane_current_path}"
          # new bind for vertical split
          bind-key "-" split-window -v -c "#{pane_current_path}"
          bind-key "_" split-window -fv -c "#{pane_current_path}"


          # reload tmux config with prefix + r
          bind r source-file ~/.config/tmux/tmux.conf # \; display "Reloaded! .config/tmux/tmux.conf"


          # set prefix to C-Space
          unbind C-Space
          set -g prefix C-Space
          bind C-Space send-prefix


          # STATUS BAR
          set -g status-bg '#${background}'
          set -g status-fg '#${foreground}'

          set -g status-interval 2

          set -g status-right-length 200
          set -g status-right '${pane_title} ${cpu_mem_load} ${clock}'
          set -g status-left '${icon}'


          set -g pane-active-border-style 'fg=#${config.lib.stylix.colors.base0D}'
          # windows
          set -g window-status-style 'fg=#${color_2.bg} bg=#${background}'
          set -g window-status-format ' #I:#W '
          set -g window-status-current-format '${current_window}'

          # set -g window-status-current-style 'underscore'


          # set-option -g status-position top
          set -s default-terminal 'tmux-256color'



          # run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
        '';
    };
  };
}
