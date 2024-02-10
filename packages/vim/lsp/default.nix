{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim9-lsp";
  version = "2024-02-09";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "bc2f5c040e9073b6253fbed2aeee3d0d013e45f6";
      sha256 = "sha256-su+yGoXkNHhMTnu9uh90f2zfiqtsv+FkckPxa/0Lm4w=";
    };

    meta.homepage = "https://www.github.com/yegappan/lsp";
  }
