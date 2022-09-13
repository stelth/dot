{
  writeShellApplication,
  tmux,
  curl,
  fzf,
}:
writeShellApplication {
  name = "tmux-cht";
  runtimeInputs = [tmux curl fzf];
  text = builtins.readFile ./tmux-cht.sh;
}
