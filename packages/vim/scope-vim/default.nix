{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "scope-vim";
  version = "2024-03-08";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "scope.vim";
      rev = "0d43eaece4fa2ad53880c943197d9fab51bf7bb6";
      sha256 = "sha256-2BPNEVc+s2Lib9NtSc7aLjANb2XZ3zZJeDI1t0AjIeA=";
    };

    meta.homepage = "https://www.github.com/girishji/scope.vim";
  }
