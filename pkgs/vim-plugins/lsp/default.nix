{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim9-lsp";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-06-06";
    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "c870798571904beddf3d5daebec5dc1f1a490ffa";
      sha256 = "a7lCEN0RO34ScGjHhtD9tBloxRmzUXHDrpFOLb6AtDc=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
