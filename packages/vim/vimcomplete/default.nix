{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
  version = "2024-03-07";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "94fdb9973dd25af816c991396a38efd962fcb6d3";
      sha256 = "sha256-F5xh9ejzIcKoQVRse0t8FPYMgLLkwaI1cV+sIXNJQLA=";
    };

    patches = [
      ./fix-getscriptinfo.patch
    ];

    meta.homepage = "https://www.github.com/girishji/vimcomplete";
  }
