{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    terminal = "tmux-256color";
    keyMode = "vi";
    mouse = true;
    disableConfirmationPrompt = true;
    clock24 = true;
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
      tmuxPlugins.sensible
      tmuxPlugins.yank
    ];
    extraConfig = ''
      set-option -sa terminal-features ",foot:RGB"
      bind-key -r f run-shell "tmux neww sessionizer"
    '';
  };
}
