{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-07-28";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "a538eb4229b4d67a61c43281f587984ec49674b3";
      sha256 = "TvU08+3h9z9orOkXNyAW4gPMUfe2puDQ/pxDi7e3jCw=";
    };
    meta.homepage = "https://github.com/girishji/vimcomplete";
  }
