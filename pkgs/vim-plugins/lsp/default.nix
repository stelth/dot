{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim9-lsp";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-06-25";
    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "0b67f2ff8ad371a66a11754c6a2ed24c808e64e4";
      sha256 = "84US7PMOw+mYFmZ/IWaAL18mazi3DiLzLya0etptp2U=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
