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
      rev = "5f01548bf499957487d026bcca03eb7bf44269de";
      sha256 = "5CMh9O/00wBp+2mW9TUxcasZJh/L9Me8vwYIgOLVU80=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
