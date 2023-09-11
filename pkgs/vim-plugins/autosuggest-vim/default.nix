{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "autosuggest-vim";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-08-18";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "autosuggest.vim";
      rev = "23f9ed167da8ac7c067b2fa1b9036d0ab868c91a";
      sha256 = "IZhm1J4pf0Bh9ncoJ2YYC5Va6LVkLCEXYYhbASlXuUA=";
    };
    meta.homepage = "https://github.com/girishji/autosuggest.vim";
  }
