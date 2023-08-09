{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-08-08";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "c5194319f1de79d9d1b8ae6bafd326f7ce539c65";
      sha256 = "HZ6/mgfOFK7yAn05x/ZF4KePGdcLW1o+ji/aTwLk0ZM=";
    };
    meta.homepage = "https://github.com/girishji/vimcomplete";
  }
