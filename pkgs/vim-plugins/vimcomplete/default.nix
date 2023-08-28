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
      rev = "045c8dc9e1dbe9efe9c642cc4a37a7663d46d0da";
      sha256 = "juwarBoq7n3qY4C0LiW8KglfWD63RwAmoANaZ8103Vc=";
    };
    meta.homepage = "https://github.com/girishji/vimcomplete";
  }
