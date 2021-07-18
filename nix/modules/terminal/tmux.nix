{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
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
    '';
  };
}
