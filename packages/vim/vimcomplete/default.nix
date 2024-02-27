{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
  version = "2024-02-27";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "254805680294f4ece1149b1d06e88f68a28def03";
      sha256 = "sha256-yFOiu0sXF79n7VxlzU/VaD1My+IMMAJZMLqq66M+9dU=";
    };

    patches = [
      ./fix-getscriptinfo.patch
    ];

    meta.homepage = "https://www.github.com/girishji/vimcomplete";
  }
