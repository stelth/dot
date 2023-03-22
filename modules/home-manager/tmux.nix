{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    terminal = "tmux-256color";
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    clock24 = true;
    plugins = with pkgs; [
      tmuxPlugins.onedark-theme
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
    ];
    extraConfig = ''
      set -g mouse on
      bind | split-window -h
      bind - split-window -v

      bind-key -r f run-shell "tmux neww tmux-sessionizer"
      bind-key -r i run-shell "tmux neww tmux-cht"
    '';
  };
}
