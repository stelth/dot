{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim9-lsp";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-07-09";
    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "4a65e149db8b0d137b369ad2edbdc57d882083c0";
      sha256 = "xhB5Bn4hv/X8DjcUu/Agy4kYBvdBJa8QJELGBkoc6QM=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
