{
  lib,
  tmux,
  writeShellApplication,
}:
writeShellApplication {
  name = "switch-back-to-nvim";
  runtimeInputs = [tmux];
  text = builtins.readFile ./switch-back-to-nvim.sh;
}
// {
  meta = with lib; {
    platforms = platforms.all;
  };
}
