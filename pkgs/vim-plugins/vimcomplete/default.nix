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
      rev = "51019d137ccad5d1d428d4fd0621607bbd452d2b";
      sha256 = "Hi8LagnisOou/r15H8FOVGdF2oGv2a/oFFZ1V9j9L2w=";
    };
    meta.homepage = "https://github.com/girishji/vimcomplete";
  }
