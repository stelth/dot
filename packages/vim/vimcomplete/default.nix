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
      rev = "9b7998ef33fbce5320ad5d1160b2cf31391962d6";
      sha256 = "sha256-MTD3iAAEVHFdsGfflC/eZK9EbFQxv6wTtKwsriVlyL8=";
    };

    patches = [
      ./fix-getscriptinfo.patch
    ];

    meta.homepage = "https://www.github.com/girishji/vimcomplete";
  }
