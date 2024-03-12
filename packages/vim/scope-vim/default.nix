{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "scope-vim";
  version = "2024-03-11";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "scope.vim";
      rev = "b09f77ea211b4e744e8dd02304fa474600987933";
      sha256 = "sha256-xmKUTnHl+uBMp6DKR47Qa4YDo+I3abUAcQhq2JyET6M=";
    };

    meta.homepage = "https://www.github.com/girishji/scope.vim";
  }
