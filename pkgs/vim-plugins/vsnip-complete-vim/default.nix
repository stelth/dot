{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vsnip-complete-vim";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-07-28";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vsnip-complete.vim";
      rev = "HEAD";
      sha256 = "gmS+xnLkXYjwPZxquY13GARNEq6urS6UwfDvo+NsMWM=";
    };
    meta.homepage = "https://github.com/girishji/vsnip-complete.vim";
  }
