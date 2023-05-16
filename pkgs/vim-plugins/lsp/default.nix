{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "lsp";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-05-13";
    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "889df762ada9a0fdd6e612a16c33b4bbc4fb09e9";
      sha256 = "sha256-vmlkGeuFUJVAvZmgWr0G+mBIGZ4wIqkNVdN8AgsWt8M=";
    };
    meta.homepage = "https://github.com/cdelledonne/vim-cmake/";
  }
