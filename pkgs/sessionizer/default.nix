{
  writeShellApplication,
  tmux,
  fzf,
}:
writeShellApplication {
  name = "sessionizer";
  runtimeInputs = [tmux fzf];
  text = builtins.readFile ./sessionizer.sh;
}
