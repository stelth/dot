{
  writeShellApplication,
  tmux,
  fzf,
}:
writeShellApplication {
  name = "tmux-sessionizer";
  runtimeInputs = [tmux fzf];
  text = builtins.readFile ./tmux-sessionizer.sh;
}
