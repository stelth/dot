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
      rev = "5c3494c71577efc757d86064c8fa53d5f3d6c804";
      sha256 = "w7/XBPD2FEPg212hszcKZ033DYDWzG4yq13LrS5xdzY=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
