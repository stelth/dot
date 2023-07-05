{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "search-complete-vim";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-07-04";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "search-complete.vim";
      rev = "c056aaea72e715b7110b9ea7eb01a398eb3bdd89";
      sha256 = "fNhyTm8FgWWZ4KBnivRVTypaM1J9rN8XMeeiRsutmqo=";
    };
    meta.homepage = "https://github.com/girishji/search-complete.vim";
  }
