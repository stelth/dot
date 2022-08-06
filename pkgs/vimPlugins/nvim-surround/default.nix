{ pkgs, ... }:
pkgs.vimUtils.buildVimPluginFrom2Nix rec {
  pname = "nvim-surround";
  version = "2022-08-05";

  src = pkgs.fetchFromGitHub {
    owner = "kylechui";
    repo = "nvim-surround";
    rev = "a06dea11e7fdcf338776fa51fa5277163ffb048d";
    sha256 = "sha256-RCwBuoc9LYDZeDy6XuxxsR7GvZgmsZca59iD4dccKH0=";
  };

  meta.homepage = "https://github.com/kylechui/nvim-surround";
}
