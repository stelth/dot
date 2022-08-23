{ writeShellApplication, tmux }:
writeShellApplication {
  name = "switch-back-to-nvim";
  runtimeInputs = [ tmux ];
  text = builtins.readFile ./switch-back-to-nvim.sh;
}
