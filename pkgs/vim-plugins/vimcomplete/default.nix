{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-08-19";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "6bfd81269df9ca7e5f59d9b8b0c3ed8fd304e2e3";
      sha256 = "XitedwPChF+MEcEXgJuC1oWW2ykgOy1iKytDrbNwRtY=";
    };
    meta.homepage = "https://github.com/girishji/vimcomplete";
  }
