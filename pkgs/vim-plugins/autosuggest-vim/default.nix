{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "autosuggest-vim";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-07-28";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "autosuggest.vim";
      rev = "0f3e891e2cc71fd9cb02a86b5b16c1f92e24acb6";
      sha256 = "w7qd2DEf0xxBoeWUvt4NDPriu5EY7UjUFgQlgj/HztY=";
    };
    meta.homepage = "https://github.com/girishji/autosuggest.vim";
  }
