{ config, pkgs, lib, ... }: {
  home.sessionVariables.LLDB_DEBUGSERVER_PATH =
    "/Library/Developer/CommandLineTools/Library/PrivateFrameworks/LLDB.framework/Versions/A/Resources/debugserver";
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
      push = "git push";
      pull = "git pull";
      su = "su -";
      df = "grc /bin/df -h";
      rga = "rg -uu";
      grep = "rg";
      show-cursor = "tput cnorm";
      hide-cursor = "tput civis";
    };
    interactiveShellInit = ''
      eval (direnv hook fish)
    '';
  };
}
