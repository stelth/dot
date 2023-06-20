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
      rev = "3850fdaf2a0c524760c276f57cff600bd75d2938";
      sha256 = "6WNOG/dXXT2KcpKoHydwaKdZu/EB0RraTpS8UCJ6do4=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
