{ config, pkgs, lib, ... }:
let theme = builtins.readFile ./fish_tokyonight_night.fish;
in {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      t = "tmux";
      tc = "tmux attach";
      ta = "tmux attach -t";
      tad = "tmux attach -d -t";
      ts = "tmux new -s";
      tl = "tmux ls";
      tk = "tmux kill-session -t";
      mux = "tmuxinator";
      mv = "mv -iv";
      cp = "cp -riv";
      mkdir = "mkdir -vp";
      l = "ll";
      ncdu = "ncdu --color dark";
      vim = "nvim";
      vi = "nvim";
      v = "nvim";
      git = "hub";
      g = "hub";
      lg = "lazygit";
      gl = "hub l --color | devmoji --log --color | less -rXF";
      st = "hub st";
      push = "hub push";
      pull = "hub pull";
      su = "su -";
      df = "grc /bin/df -h";
      rga = "rg -uu";
      grep = "rg";
      show-cursor = "tput cnorm";
      hide-cursor = "tput civis";
    };
    functions = { yabai_fix = "pgrep yabai | xargs kill"; };
    interactiveShellInit = ''
      set -x LLDB_DEBUGSERVER_PATH /Library/Developer/CommandLineTools/Library/PrivateFrameworks/LLDB.framework/Versions/A/Resources/debugserver
        ${theme}
      eval (direnv hook fish)
    '';
  };
}
