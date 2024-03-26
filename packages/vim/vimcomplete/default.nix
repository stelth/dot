{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
  version = "2024-03-24";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "e71912e467ba07925ee3ca7fce1f96774582f232";
      sha256 = "sha256-fyUGflWV0fl5f0b1vYs3zKFEBFQWqjnv6HIes7SDiTU=";
    };

    patches = [
      ./fix-getscriptinfo.patch
    ];

    meta.homepage = "https://www.github.com/girishji/vimcomplete";
  }
