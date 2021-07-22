{ config, pkgs, lib, ... }:
let
  theme = builtins.readFile ./fish_tokyonight_night.fish;
in
{
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
      show = "cursor tput cnorm";
      hide = "cursor tput civis";
    };
    functions = {
      yabai_fix = "pgrep yabai | xargs kill";
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
      ${theme}
    '';
  };
}
