{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-07-28";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "4ee87ba6c500525f305d9130bbd3e13209400eb6";
      sha256 = "2YcLajV+hwpunkv+xlIzNYWOYAIB/W9iV3sYd7G3R6g=";
    };
    meta.homepage = "https://github.com/girishji/vimcomplete";
  }
