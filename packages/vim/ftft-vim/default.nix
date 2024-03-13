{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "fTtT-vim";
  version = "2024-03-10";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "fFtT.vim";
      rev = "f9533b1c1087aeefdcc207b22b9f5b1db4335da6";
      sha256 = "sha256-g+jvPo4tSPCZXsrfTwzWD3aT3bLwDAcL2VdVmsOt/0Q=";
    };

    meta.homepage = "https://www.github.com/girishji/fFtT.vim";
  }
