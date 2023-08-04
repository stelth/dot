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
      rev = "7c683b69f8d1c4b35bac41f35d9200e16c4aa1a0";
      sha256 = "WdqS5Q4127seLDvBp0aS1zQGq+JdYUvUPPr1zKEDUvk=";
    };
    meta.homepage = "https://github.com/girishji/autosuggest.vim";
  }
