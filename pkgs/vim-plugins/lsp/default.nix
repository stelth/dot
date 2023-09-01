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
      rev = "63156bca96e497e6e00c04c8e1180c120cd43fee";
      sha256 = "NkkG8fAdj/cQTlgW28d12227RcUbl37NfjFjpeiKdbg=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
