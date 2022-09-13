{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    terminal = "screen-256color";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    clock24 = true;
    extraConfig = ''
      set -g mouse on
      set-option -sa terminal-overrides ',xterm-256color:RGB'
      bind r source-file ~/.config/tmux/tmux.conf
      bind | split-window -h
      bind - split-window -v
      set -g status-style 'bg=#333333 fg=#5EACD3'

      bind-key -r f run-shell "tmux neww tmux-sessionizer"
      bind-key -r i run-shell "tmux neww tmux-cht"
      bind-key -r n run-shell "switch-back-to-nvim"

      bind-key -r ^ last-window
    '';
  };
}
