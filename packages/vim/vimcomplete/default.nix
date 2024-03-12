{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
  version = "2024-03-11";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "144675e1d026377017a1b8aec5eb9cd73721616f";
      sha256 = "sha256-FIK+elq/zFiKFSnU8+4XpX3muKHqOYOxuTE9Pa22Hnc=";
    };

    patches = [
      ./fix-getscriptinfo.patch
    ];

    meta.homepage = "https://www.github.com/girishji/vimcomplete";
  }
