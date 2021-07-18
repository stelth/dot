{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      la = "exa --color=always --icons --group-directories-first --all";
      ls = "exa --color=always --icons --group-directories-first";
      ll = "exa --color=always --icons --group-directories-first --all --long";
    };
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
      show = "cursor tput cnorm";
      hide = "cursor tput civis";
    };
    functions = {
      yabai_fix = "pgrep yabai | tail -n +2 | head -n1 | xargs kill";
    };
    plugins = [
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
          sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
        };
      }
    ];
    interactiveShellInit = ''
      fish_vi_key_bindings
      set fish_greeting

      zoxide init fish | source

      # TokyoNight Color Palette
      set -l foreground c0caf5
      set -l selection 33467C
      set -l comment 565f89
      set -l red f7768e
      set -l orange ff9e64
      set -l yellow e0af68
      set -l green 9ece6a
      set -l purple 9d7cd8
      set -l cyan 7dcfff
      set -l pink bb9af7

      # Syntax Highlighting Colors
      set -g fish_color_normal $foreground
      set -g fish_color_command $cyan
      set -g fish_color_keyword $pink
      set -g fish_color_quote $yellow
      set -g fish_color_redirection $foreground
      set -g fish_color_end $orange
      set -g fish_color_error $red
      set -g fish_color_param $purple
      set -g fish_color_comment $comment
      set -g fish_color_selection --background=$selection
      set -g fish_color_search_match --background=$selection
      set -g fish_color_operator $green
      set -g fish_color_escape $pink
      set -g fish_color_autosuggestion $comment

      # Completion Pager Colors
      set -g fish_pager_color_progress $comment
      set -g fish_pager_color_prefix $cyan
      set -g fish_pager_color_completion $foreground
      set -g fish_pager_color_description $comment
    '';
  };
}
