{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim9-lsp";
  version = "2024-02-26";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "0b9bba0ee4eaa84a75d88a0775b3b34dbf42b12d";
      sha256 = "sha256-tNOUJw/4MtlwK3PJxlRSd9gosfAF4uX778wwZFsTF78=";
    };

    meta.homepage = "https://www.github.com/yegappan/lsp";
  }
