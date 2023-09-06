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
      rev = "ff879850a392a5dab37f1763e51a1c27617a9ee5";
      sha256 = "xA2L8OQW/cZkqKcCf+onxHTnBS9niA2WXhXyzV9tQ2g=";
    };
    meta.homepage = "https://github.com/girishji/vimcomplete";
  }
