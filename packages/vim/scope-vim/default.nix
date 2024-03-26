{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "scope-vim";
  version = "2024-03-24";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "scope.vim";
      rev = "e94143a48ce64860ddb400ebbe731f61b5a10bff";
      sha256 = "sha256-S521Nc4vRNCYwACgJLbhLMsWTC6dSrv6DFZiXvOlCtE=";
    };

    meta.homepage = "https://www.github.com/girishji/scope.vim";
  }
