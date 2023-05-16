{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim-system-copy";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2022-11-22";
    src = fetchFromGitHub {
      owner = "christoomey";
      repo = "vim-system-copy";
      rev = "e9cf05fc05ea84c834b6e73104a6dfa1862db3e6";
      sha256 = "1ahq88g3ja0zrgqxxa7k841zi9x4gmf05f46xbqfk7gwcnidfvxz";
    };
    meta.homepage = "https://github.com/christoomey/vim-system-copy/";
  }
