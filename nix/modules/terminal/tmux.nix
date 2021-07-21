{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    terminal = "xterm-kitty";
    keyMode = "vi";
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      tmuxPlugins.yank
      tmuxPlugins.nord
      tmuxPlugins.prefix-highlight
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'off'
        '';
      }
      {
        plugin = tmuxPlugins.tilish;
        extraConfig = ''
          set -g @tilish-default 'tiled'
        '';
      }
    ];
    extraConfig = ''
      set -g mouse on
      set -g renumber-windows on
      setw -g monitor-activity on
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

      version_pat='s/^tmux[^0-9]*([.0-9]+).*/\1/p'

      is_vim="ps -a | grep -qE '#{s|/dev/||:pane_tty}\'\'.*(n?)vim'"
      bind-key -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
      bind-key -n C-j if-shell "$is_vim" "send-keys C-j" "select-pane -D"
      bind-key -n C-k if-shell "$is_vim" "send-keys C-k" "select-pane -U"
      bind-key -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"
      tmux_version="$(tmux - V | sed - En "$version_pat")"
      setenv -g tmux_version "$tmux_version"

      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
      "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
      "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi C-h select-pane -L
      bind-key -T copy-mode-vi C-j select-pane -D
      bind-key -T copy-mode-vi C-k select-pane -U
      bind-key -T copy-mode-vi C-l select-pane -R
      bind-key -T copy-mode-vi C-\\ select-pane -l
    '';
  };
}
