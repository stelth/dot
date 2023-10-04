{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-10-03";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "838326b16c627718d1814980988db46ec5e83104";
      sha256 = "yPP2vn8AanZLM1+LCJinoPJ3u1FrGvk2+9pE08HklLk=";
    };
    meta.homepage = "https://github.com/girishji/vimcomplete";
  }
