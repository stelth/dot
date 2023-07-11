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
      rev = "58a93a2b93302a9a63cb1df2ae3b1b1b88cbb1c5";
      sha256 = "O7Tko3VC5cneuy3FsppSKglVQYPiykN/Q8a27B87BcY=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
