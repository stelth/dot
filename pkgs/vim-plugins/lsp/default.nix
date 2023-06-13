{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim9-lsp";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-06-10";
    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "89583823a73ea867057604f1a88f4174500df98e";
      sha256 = "a7lCEN0RO34ScGjHhtD9tBloxRmzUXHDrpFOLb6AtDc=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
