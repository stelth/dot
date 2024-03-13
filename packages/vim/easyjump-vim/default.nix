{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "easyjump-vim";
  version = "2024-03-10";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "easyjump.vim";
      rev = "138f0cdf9d9146c110d6ecca30afb1bfeaebb80c";
      sha256 = "sha256-00vQhG2Ja2kXTBq/OuIat5WJGg5Ccz++Th19L+aDgGM=";
    };

    meta.homepage = "https://www.github.com/girishji/easyjump.vim";
  }
