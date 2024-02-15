{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim9-lsp";
  version = "2024-02-14";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "87189faf0bd4a2f974408df2d8c261dbfc3348dd";
      sha256 = "sha256-5oyaO5riYxFx+rKYzO4qUPuWfOtxI9oDOAjzKoteT34=";
    };

    meta.homepage = "https://www.github.com/yegappan/lsp";
  }
