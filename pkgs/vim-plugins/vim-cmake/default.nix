{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim-cmake";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-02-13";
    src = fetchFromGitHub {
      owner = "cdelledonne";
      repo = "vim-cmake";
      rev = "6b7b18130c30e1d498c0ec8fca3c18951273e4ea";
      sha256 = "1kfi8nv7g4s7kzqzy79ghq70l4nyqm1rknl8iyxkq44j7k7sdpdm";
    };
    meta.homepage = "https://github.com/cdelledonne/vim-cmake/";
  }
