{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "scope-vim";
  version = "2024-03-17";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "scope.vim";
      rev = "f3af0a17d975923523019811773eb898bd259495";
      sha256 = "sha256-Vl5ZO27nJJANroojgAQVGiEHLBTKzuSApOySNvhA0Ow=";
    };

    meta.homepage = "https://www.github.com/girishji/scope.vim";
  }
