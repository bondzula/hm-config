{ pkgs, ... }:

{
  # Install gitmux
  home.packages = with pkgs; [ gitmux ];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    mouse = true;
    keyMode = "vi";
    escapeTime = 0;
    aggressiveResize = true;
    historyLimit = 5000;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    extraConfig = ''
      set -g detach-on-destroy off  # don't exit from tmux when closing a session 
      set -g history-limit 1000000  # significantly increase history size
      set -g renumber-windows on    # renumber all windows when any window is closed
      set -g set-clipboard on       # use system clipboard
      set -g status-interval 2      # update status every 2 seconds
      set -g status-left-length 200 # increase status line length
      set -g status-position top    # macOS / darwin style
      set -g status-right ""        # empty

      set -g status-left                  "#[fg=blue,bold]#S"
      set -ga status-left                 "#[fg=white,nobold]#(gitmux -timeout 200ms -cfg $HOME/.config/tmux/gitmux.yml) "
      set -g pane-active-border-style     "fg=magenta,bg=default"
      set -g pane-border-style            "fg=brightblack,bg=default"
      set -g status-style                 "bg=default" # transparent
      set -g window-status-current-format "#[fg=magenta]#W"
      set -g window-status-format         "#[fg=gray]#W"

      set-option -g automatic-rename-format "#(tmux-icon-name #{pane_current_command})"
      set-option -g default-terminal        "screen-256color"
      set-option -g terminal-overrides      ",xterm-256color:RGB"

      bind "%" split-window  -c "#{pane_current_path}" -h
      bind '"' split-window  -c "#{pane_current_path}"
      bind c   new-window    -c "#{pane_current_path}"
      bind c   new-window    -c "#{pane_current_path}"
      bind g   new-window    -n "" lazygit
      bind t   run-shell     -b "tmux-sessionizer"
      bind L   switch-client -l
      bind h   select-pane   -L
      bind j   select-pane   -D
      bind k   select-pane   -U
      bind l   select-pane   -R

      bind-key -T copy-mode-vi 'C-\' select-pane -l
      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'v'   send-keys -X begin-selection
      bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt (cmd+w)
    '';
    plugins = with pkgs; [ tmuxPlugins.fzf-tmux-url ];
  };

  # Setup the configuration file for gitmux
  xdg.configFile."tmux/gitmux.yml" = {
    text = ''
      tmux:
        symbols:
          branch: " שׂ "
          hashprefix: ":"
          ahead: " "
          behind: " "
          staged: "都"
          conflict: "繁"
          untracked: " "
          modified: " "
          stashed: " "
          clean: ""
          insertions: " "
          deletions: " "
        styles:
          state: "#[fg=red,nobold]"
          branch: "#[fg=white,nobold]"
          staged: "#[fg=green,nobold]"
          conflict: "#[fg=red,nobold]"
          modified: "#[fg=yellow,nobold]"
          untracked: "#[fg=gray,nobold]"
          stashed: "#[fg=gray,nobold]"
          clean: "#[fg=green,nobold]"
          divergence: "#[fg=cyan,nobold]"
        layout: [branch, divergence, " ", flags, " ", stats, " "]
        options:
          branch_max_len: 0
    '';
  };
}
