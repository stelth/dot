{ writeShellApplication, tmux, ghq, fzf }:
writeShellApplication {
  name = "tmux-sessionizer";
  runtimeInputs = [ tmux ghq fzf ];
  text = builtins.readFile ./tmux-sessionizer.sh;
}
