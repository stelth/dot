{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-08-05";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "1c64cf4397741b7245046496fe4b8107960a403e";
      sha256 = "VfE/CLF5pCOCZvNjP6FuE+4HBeXwCrzKEtzr8ObZNGA=";
    };
    meta.homepage = "https://github.com/girishji/vimcomplete";
  }
