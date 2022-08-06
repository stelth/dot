{ pkgs, ... }:
pkgs.vimUtils.buildVimPluginFrom2Nix rec {
  pname = "leap-nvim";
  version = "2022-08-02";

  src = pkgs.fetchFromGitHub {
    owner = "ggandor";
    repo = "leap.nvim";
    rev = "a9949044bc59b0ae026c2e8394da826069049211";
    sha256 = "sha256-wfppbg8PsjAMHFsqAyNNcMxvMMpcPwzrG6saSxNxQ+Q=";
  };

  meta.homepage = "https://github.com/ggandor/leap.nvim";
}
