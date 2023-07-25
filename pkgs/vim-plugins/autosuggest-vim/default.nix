{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "autosuggest-vim";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-07-04";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "autosuggest.vim";
      rev = "550a025ec373d83e1565ec583276008ea6c1dfb3";
      sha256 = "h2Tsb8ts9spepxeTQjaamEECLNSc34aYFsIrieuYXcg=";
    };
    meta.homepage = "https://github.com/girishji/autosuggest.vim";
  }
