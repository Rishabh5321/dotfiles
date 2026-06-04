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
          palette = if (config ? stylix && config.stylix.enable) then config.lib.stylix.colors else {
            base00 = "000000";
            base01 = "1e1e2e";
            base02 = "313244";
            base03 = "45475a";
            base04 = "585b70";
            base05 = "cdd6f4";
            base06 = "f5e0dc";
            base07 = "b4befe";
            base08 = "f38ba8";
            base09 = "fab387";
            base0A = "f9e2af";
            base0B = "a6e3a1";
            base0C = "94e2d5";
            base0D = "89b4fa";
            base0E = "cba6f7";
            base0F = "f2cdcd";
          };

          background = "${palette.base01}";
          foreground = "${palette.base04}";

          r_arrow = { fg, bg }: ''#[fg=#${fg},bg=#${bg}]'';
          l_arrow = { fg, bg }: ''#[fg=#${fg},bg=#${bg}]'';

          color_1 = {
            fg = "${palette.base00}";
            bg = "${palette.base08}";
          };
          color_2 = {
            fg = "${palette.base00}";
            bg = "${palette.base0A}";
          };
          color_3 = {
            fg = "${palette.base00}";
            bg = "${palette.base0B}";
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
              inherit (color_1) bg;
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


          set -g pane-active-border-style 'fg=#${palette.base0D}'
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
