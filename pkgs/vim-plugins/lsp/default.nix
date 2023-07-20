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
      rev = "b56d6c119c1a1d28c8b3acf7f304f8c02ef5f5e5";
      sha256 = "kaRiVpmb44LDtvjS7zadlxvNl7WzHa/GnCvRlHum2U0=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
