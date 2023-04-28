{
  pkgs,
  lib,
  ...
}:
pkgs.writers.writePython3Bin "sysdo" {
  flakeIgnore = ["E501" "W503" "W391"];
  libraries = with pkgs.python3Packages; [typer];
} ''
  ${builtins.readFile ./do.py}
''
// {
  meta = with lib; {
    platforms = platforms.all;
  };
}
