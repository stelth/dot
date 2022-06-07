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
    tmuxinator.enable = true;
    plugins = with pkgs; [ tmuxPlugins.yank ];
    extraConfig = ''
      set -g mouse on
      set -g renumber-windows on
      setw -g monitor-activity on
      bind | split-window -h
      bind - split-window -v
      set -g status-style 'bg=#333333 fg=#5EACD3'
    '';
  };
}
