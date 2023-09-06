{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim9-lsp";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-08-14";
    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "28cab9a8992b9331dadd6af3615f85d1f1999f16";
      sha256 = "ThZaFNX/Amfk1Wxxz3cE34sVSHfDEEVYkr50ssyBFkI=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
