{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim9-lsp";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-09-13";
    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "22330283aba45977b0391234c1475e7a369371ea";
      sha256 = "uLgNOVjEfupYozeViWYriMb8rnUrFgpgwPlA4WJh3A0=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
