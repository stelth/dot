{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim9-lsp";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-07-28";
    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "e117912131d18ece0c97248e142606da2844c56d";
      sha256 = "37sPeWybCSE2jF4ObxfuBOPPchUtlCjEH4QMAmsbOlk=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
