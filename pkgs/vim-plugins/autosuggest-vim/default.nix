{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "autosuggest-vim";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-08-18";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "autosuggest.vim";
      rev = "20aab73efa48e4af7ec1b4108f088b2eb85e61e9";
      sha256 = "RBFlpl0MDWQxNXvctkdCW1LU0WbPad/VDOfEtyondmY=";
    };
    meta.homepage = "https://github.com/girishji/autosuggest.vim";
  }
