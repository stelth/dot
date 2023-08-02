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
      rev = "828c94e43bf06ca04111cd56e51974af8a540778";
      sha256 = "gmS+xnLkXYjwPZxquY13GARNEq6urS6UwfDvo+NsMWM=";
    };
    meta.homepage = "https://github.com/girishji/vsnip-complete.vim";
  }
