{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "autosuggest-vim";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-10-01";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "autosuggest.vim";
      rev = "b2a725b49f74cf018bf4c53e638d1df7a790bb59";
      sha256 = "HP1jXrp3l9Z3wviUT/8I6Z+Be9k3AMPxnqQporFkUPk=";
    };
    meta.homepage = "https://github.com/girishji/autosuggest.vim";
  }
