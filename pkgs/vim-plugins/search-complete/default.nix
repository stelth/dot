{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "search-complete-vim";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-06-25";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "search-complete.vim";
      rev = "edc7111e771fa03d175994e5f0a0ac895b72e0df";
      sha256 = "MCcEgV2pgawwEP5cBTIoCuA+OwovOVaNqdSSPaBYh7g=";
    };
    meta.homepage = "https://github.com/girishji/search-complete.vim";
  }
