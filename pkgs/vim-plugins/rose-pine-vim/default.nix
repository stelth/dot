{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "rose-pine-vim";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-01-16";
    src = fetchFromGitHub {
      owner = "rose-pine";
      repo = "vim";
      rev = "d149980cfa5cdec487df23b2e9963c3256f3a9f3";
      sha256 = "a+RCmgSG+snwBVQCzSnp8wVxSoQcLqoJjnTiDviTGqc=";
    };
    meta.homepage = "https://github.com/rose-pine/vim";
  }
