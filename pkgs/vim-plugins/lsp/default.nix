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
      rev = "6e4ba228eaa0770470060d8d47a360bd05a04ee5";
      sha256 = "95thBY7pfMYzSCH6cYfiT2m5nk1FDfDK2Xs3G1WRmUg=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
