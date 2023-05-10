{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    terminal = "tmux-256color";
    keyMode = "vi";
    mouse = true;
    disableConfirmationPrompt = true;
    clock24 = true;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.yank
    ];
    extraConfig = ''
      bind | split-window -h
      bind - split-window -v

      bind-key -r f run-shell "tmux neww sessionizer"
      bind-key -r i run-shell "tmux neww tmux-cht"

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
             | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|\.?n?vim?x?(-wrapped)?)(diff)?$'"

      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l
    '';
  };
}
