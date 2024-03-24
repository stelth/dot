{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "scope-vim";
  version = "2024-03-24";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "scope.vim";
      rev = "3a51d790ed438f33f77050adcb58ed6e6c476b3b";
      sha256 = "sha256-ae5AfRzv19VlDQvmaFDTVXQoDVWRwwsz/wSJRC3CPaw=";
    };

    meta.homepage = "https://www.github.com/girishji/scope.vim";
  }
