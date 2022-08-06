{ pkgs, ... }:
pkgs.vimUtils.buildVimPluginFrom2Nix rec {
  pname = "staline-nvim";
  version = "2022-08-03";

  src = pkgs.fetchFromGitHub {
    owner = "tamton-aquib";
    repo = "staline.nvim";
    rev = "3559cb72c035c2aa0fc5d52aade270ab6cc680c3";
    sha256 = "sha256-hAP5n5LaeD1321JY8pEd1nw4zvBn7xkHm2W8wyhuF+I=";
  };

  meta.homepage = "https://github.com/tamton-aquib/staline.nvim";
}
