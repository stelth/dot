{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-08-10";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "6d43bf2d9d0910f3d6ddad671e2069e7c05efac4";
      sha256 = "zcBIcx5G0rlXP4A+NMr4q05oMh8yCtaJ05OeNMtQaVU=";
    };
    meta.homepage = "https://github.com/girishji/vimcomplete";
  }
