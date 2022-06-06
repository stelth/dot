{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    terminal = "xterm-256color";
    keyMode = "vi";
    clock24 = true;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    tmuxinator.enable = true;
    plugins = with pkgs; [ tmuxPlugins.yank ];
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
    '';
  };
}
