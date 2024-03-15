{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "scope-vim";
  version = "2024-03-15";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "scope.vim";
      rev = "005bbbfe95fef01fcf78d67a89e2286b25be24e3";
      sha256 = "sha256-K8AydK0SSQlL7vmcw7G2KJpxMk9v+fLT5X2iE2NFL3Q=";
    };

    meta.homepage = "https://www.github.com/girishji/scope.vim";
  }
