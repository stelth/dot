{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
  version = "2024-02-13";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "d86a957ce39af599287ffe028ef5400454f22f2b";
      sha256 = "sha256-kgY4zYxfhg0dv4EwU/vwcHlA74ptiMkZGbKHnlzr6vo=";
    };

    patches = [
      ./fix-getscriptinfo.patch
    ];

    meta.homepage = "https://www.github.com/girishji/vimcomplete";
  }
