{
  pkgs,
  lib,
  ...
}: {
  programs = {
    fzf = rec {
      enable = true;
      defaultCommand = "${lib.getExe pkgs.fd} --type f";
      defaultOptions = ["--height 50%"];
      fileWidgetCommand = "${defaultCommand}";
      fileWidgetOptions = [
        "--preview '${lib.getExe pkgs.bat} --color=always --plain --line-range=:200 {}'"
      ];
      changeDirWidgetCommand = "${lib.getExe pkgs.fd} --type d";
      changeDirWidgetOptions = [
        "--preview '${pkgs.tree}/bin/tree -C {} | head -200'"
      ];
      historyWidgetOptions = [];
    };
  };
}
