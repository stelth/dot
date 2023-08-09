{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "autosuggest-vim";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-08-08";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "autosuggest.vim";
      rev = "44ccd7b5da062511d4d2acd094df12835b86658a";
      sha256 = "mueFmWhOQdgPRN+nGBPCh84tICR02nNMIiaIhr5C54U=";
    };
    meta.homepage = "https://github.com/girishji/autosuggest.vim";
  }
