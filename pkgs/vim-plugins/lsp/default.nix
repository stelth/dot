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
      rev = "c5bcc14b14e57ad9f710da87640888894ff23e76";
      sha256 = "pTrxD6Aziv7ETNh4FTb/5Tfwt7jg+A62TdgUZWRlPHE=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
