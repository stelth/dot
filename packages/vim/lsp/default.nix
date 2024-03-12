{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim9-lsp";
  version = "2024-03-12";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "9111948aa541df98c66da57ab34e3f9914f44d01";
      sha256 = "sha256-9lWv3I+tfuYkEwKfq4/JZ4lnNV5nmpqguA02gwY66RU=";
    };

    meta.homepage = "https://www.github.com/yegappan/lsp";
  }
