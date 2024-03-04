{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
  version = "2024-03-03";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "53abffd3d5e4293a5df301e066f546ff34d19ff6";
      sha256 = "sha256-egxtw6dYHbfv2/MXGR4oyzMv5SQxcweTVP1bU958sRw=";
    };

    patches = [
      ./fix-getscriptinfo.patch
    ];

    meta.homepage = "https://www.github.com/girishji/vimcomplete";
  }
