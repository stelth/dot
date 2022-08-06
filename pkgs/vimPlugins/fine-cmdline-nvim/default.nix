{ pkgs, ... }:
pkgs.vimUtils.buildVimPluginFrom2Nix rec {
  pname = "fine-cmdline-nvim";
  version = "2022-07-01";

  src = pkgs.fetchFromGitHub {
    owner = "VonHeikemen";
    repo = "fine-cmdline.nvim";
    rev = "ead2b85e455eacde10469a8fcf1a717822d2bb9a";
    sha256 = "sha256-0aYHz6uRMVjctrDo8JKlTIUP2Oj+MrhBvgXRIwo/ueU=";
  };

  dependencies = with pkgs.vimPlugins; [ nui-nvim ];

  meta.homepage = "https://github.com/VonHeikemen/fine-cmdline.nvim";
}
