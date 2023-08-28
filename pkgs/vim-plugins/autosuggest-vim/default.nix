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
      rev = "78648811b0d18e6da33fde46db7ad033c73d5c6b";
      sha256 = "f7KhemZuOBE/57BKx8USRFlUM1dayc+4UYVDqVaorv8=";
    };
    meta.homepage = "https://github.com/girishji/autosuggest.vim";
  }
