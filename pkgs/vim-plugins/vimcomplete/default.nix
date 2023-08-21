{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-08-19";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "7bbb2531412a93829a969182278aceb8d986ff3f";
      sha256 = "tN0o4am/N6Q/itvu+33NNX2Aql29XWPE5jRui4GjzcU=";
    };
    meta.homepage = "https://github.com/girishji/vimcomplete";
  }
