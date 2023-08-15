{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-08-11";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "55014483a2b1236b0c3405a6188ebcd7d6c5eacf";
      sha256 = "MBQySp6cwkEljGl31M+H8bxAAR18vrSBILf08CHd65E=";
    };
    meta.homepage = "https://github.com/girishji/vimcomplete";
  }
