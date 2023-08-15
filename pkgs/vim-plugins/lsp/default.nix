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
      rev = "530abb945070f204ebdb2de5db4cb2920fb9f31e";
      sha256 = "ZfMLnpdLKV9PCmmA9nHeqCO6id2Sy9Xi1HWorPJYv94=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
