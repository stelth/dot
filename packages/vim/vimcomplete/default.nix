{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
  version = "2024-02-09";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "0747104e03c82244a1623fddae60d7ddc5eac969";
      sha256 = "sha256-qR+DYwF2dwIkwsf3TvZUQ+jit1uSwTl2rp8RYnO3MMg=";
    };

    meta.homepage = "https://www.github.com/girishji/vimcomplete";
  }
