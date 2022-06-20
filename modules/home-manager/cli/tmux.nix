{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    terminal = "xterm-256color";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    extraConfig = ''
      set -g mouse on
      bind r source-file ~/.config/tmux/tmux.conf
      bind | split-window -h
      bind - split-window -v
      set -g status-style 'bg=#333333 fg=#5EACD3'

      bind-key -r f run-shell "tmux neww tmux-sessionizer"
      bind-key -r i run-shell "tmux neww tmux-cht"

      bind-key -r ^ last-window
    '';
  };
}
