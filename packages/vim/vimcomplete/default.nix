{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vimcomplete";
  version = "2024-03-15";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "a3c38b63e5a8dc0ad882412163675e613e5bd26d";
      sha256 = "sha256-L7AKxF3h4OLylnejp475AkxJO8xeVSufl8KD7c9QiOM=";
    };

    patches = [
      ./fix-getscriptinfo.patch
    ];

    meta.homepage = "https://www.github.com/girishji/vimcomplete";
  }
