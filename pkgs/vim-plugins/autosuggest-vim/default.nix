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
      rev = "daf6a441f0043dceb5a4f4863d61ba9fa256901a";
      sha256 = "VME3AEz2rJl13dsXIcZ/+AO9anE1HL0iRsPjJBWrnNo=";
    };
    meta.homepage = "https://github.com/girishji/autosuggest.vim";
  }
